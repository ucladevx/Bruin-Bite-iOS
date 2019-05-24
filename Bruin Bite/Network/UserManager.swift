//
//  UserManager.swift
//  Bruin Bite
//
//  Created by Samuel J. Lee on 11/16/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import Moya

class UserManager {
    private let provider = MoyaProvider<MainAPI>()
    static let shared: UserManager = UserManager()
    private var currentUser: UserModel

    //Delegates
    var signupDelegate: SignupDelegate? = nil // The first signup vc will be this delegate.
    var loginDelegate: LoginDelegate? = nil // Login VC will be this delegate
    var readDelegate: ReadDelegate? = nil
    var logoutDelegate: LogoutDelegate? = nil
    var deleteUserDelegate: DeleteUserDelegate? = nil
    var updateDelegate: UpdateDelegate? = nil
    var refreshDelegate: RefreshDelegate? = nil

    private init() {
        currentUser = UserModel()
    }

    private func extractErrorType(from error: UserError) -> String {
        if let errorDetail = error.email?[0] { return errorDetail }
        else if let errorDetail = error.password?[0] { return errorDetail }
        else if let errorDetail = error.detail { return errorDetail }
        else if let errorDetail = error.error { return errorDetail }
        else if let errorDetail = error.error_description { return errorDetail }
        return ""
    }

    func createUser(email: String, password: String, firstName: String) {
        provider.request(.createUser(email: email, password: password, firstName: firstName, is_active: true)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(UserCreate.self, from: response.data)
                    UserDefaultsManager.shared.setUserEmail(to: results.email)
                    UserDefaultsManager.shared.setUserID(to: results.id)
                    UserDefaultsManager.shared.setFirstName(to: results.first_name)
                    self.currentUser.uFirstName = results.first_name
                    self.currentUser.uEmail = results.email
                    self.currentUser.uID = results.id
                    self.signupDelegate?.didFinishSignup()
                } catch let err {
                    do {
                        print("Error: Code \(err)")
                        let error = try JSONDecoder().decode(UserError.self, from: response.data)
                        self.signupDelegate?.signUpFailed(error: self.extractErrorType(from: error))
                    }
                    catch let unexpectedErr {
                        print("Unexpected Error! --- \(unexpectedErr)")
                    }
                }
            case let .failure(error):
                self.signupDelegate?.signUpFailed(error: error.errorDescription ?? "")
            }
        }
    }

    func loginUser(email: String, password: String) {
        provider.request(.loginUser(username: email, password: password, grant_type: "password", client_id: CLIENTID, client_secret: CLIENTSECRET)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(UserLog.self, from: response.data)
                    UserDefaultsManager.shared.setAccessToken(to: results.access_token)
                    UserDefaultsManager.shared.setRefreshToken(to: results.refresh_token)
                    UserDefaultsManager.shared.setUserEmail(to: email)
                    self.currentUser.access_token = results.access_token
                    self.currentUser.refresh_token = results.refresh_token
                    self.loginDelegate?.didLogin()
                } catch let err {
                    do {
                        print("Error: Code \(err)")
                        let error = try JSONDecoder().decode(UserError.self, from: response.data)
                        self.loginDelegate?.loginFailed(error: self.extractErrorType(from: error))
                    }
                    catch let unexpectedErr {
                        print("Unexpected Error! --- \(unexpectedErr)")
                    }
                }
            case let .failure(error):
                self.loginDelegate?.loginFailed(error: error.errorDescription ?? "")
            }
        }
    }

    func signupUpdate(email: String, first_name: String, last_name: String, major: String, minor: String, year: Int, self_bio: String) {
        DispatchQueue.global(qos: .background).async {
            self.provider.request(.updateUser(email: email, first_name: first_name, last_name: last_name, major: major, minor: minor, year: year, self_bio: self_bio)) { result in
                switch result {
                case let .success(response):
                    do {
                        let results = try JSONDecoder().decode(UserCreate.self, from: response.data)
                        self.updateCurrentUser(newUserInfo: results)
                        self.updateDelegate?.didUpdateUser()
                    } catch let err {
                        do {
                            print("Error: Code \(err)")
                            let error = try JSONDecoder().decode(UserError.self, from: response.data)
                            self.updateDelegate?.updateFailed(error: self.extractErrorType(from: error))
                        }
                        catch let unexpectedErr {
                            print("Unexpected Error! --- \(unexpectedErr)")
                        }
                    }
                case let .failure(error):
                    self.updateDelegate?.updateFailed(error: error.errorDescription ?? "")
                }
            }
        }
    }

    func readUser(email: String) {
        self.provider.request(.readUser(email: email)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(UserCreate.self, from: response.data)
                    self.updateCurrentUser(newUserInfo: results)
                    self.readDelegate?.didReadUser()
                    self.provider.request(.updateDeviceID) { _ in }
                } catch let err {
                    do {
                        print("Error: Code \(err)")
                        let error = try JSONDecoder().decode(UserError.self, from: response.data)
                        self.readDelegate?.readFailed(error: self.extractErrorType(from: error))
                    }
                    catch let unexpectedErr {
                        print("Unexpected Error! --- \(unexpectedErr)")
                    }
                }
            case let .failure(error):
                self.readDelegate?.readFailed(error: error.errorDescription ?? "")
            }
        }
    }

    func getNewAccessToken(refreshToken: String) {
        self.provider.request(.refreshToken(grant_type: "refresh_token", client_id: CLIENTID, client_secret: CLIENTSECRET, refresh_token: refreshToken)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(UserLog.self, from: response.data)
                    UserDefaultsManager.shared.setAccessToken(to: results.access_token)
                    UserDefaultsManager.shared.setRefreshToken(to: results.refresh_token)
                    self.currentUser.access_token = results.access_token
                    self.currentUser.refresh_token = results.refresh_token
                    self.refreshDelegate?.didRefreshToken()
                } catch let err {
                    do {
                        print("Error: Code \(err)")
                        let error = try JSONDecoder().decode(UserError.self, from: response.data)
                        print(error)
                        self.refreshDelegate?.refreshFailed()
                    }
                    catch let unexpectedErr {
                        print("Unexpected Error! --- \(unexpectedErr)")
                    }
                }
            case let .failure(error):
                print(error)
                self.refreshDelegate?.networkFailure()
            }
        }
    }

    func logOutUser(token: String) {
        self.provider.request(.logoutUser(token: token, client_id: CLIENTID, client_secret: CLIENTSECRET)) { result in
            switch result {
            case .success:
                self.refreshUser()
                self.logoutDelegate?.didCompleteLogout()
            case let .failure(error):
                print(error)
                self.logoutDelegate?.logoutFailed()
            }
        }
    }

    func refreshUser() {
        UserDefaultsManager.shared.removeAll()
        self.currentUser = UserModel()
    }

    private func updateCurrentUser(newUserInfo: UserCreate) {
        self.currentUser.uBio = newUserInfo.self_bio
        self.currentUser.uFirstName = newUserInfo.first_name
        self.currentUser.uLastName = newUserInfo.last_name
        self.currentUser.uMajor = newUserInfo.major
        self.currentUser.uMinor = newUserInfo.minor
        self.currentUser.uYear = newUserInfo.year
        self.currentUser.uID = newUserInfo.id
        self.currentUser.uEmail = newUserInfo.email
        UserDefaultsManager.shared.setSelfBio(to: newUserInfo.self_bio)
        UserDefaultsManager.shared.setFirstName(to: newUserInfo.first_name)
        UserDefaultsManager.shared.setLastName(to: newUserInfo.last_name)
        UserDefaultsManager.shared.setMajor(to: newUserInfo.major)
        UserDefaultsManager.shared.setMinor(to: newUserInfo.minor)
        UserDefaultsManager.shared.setYear(to: newUserInfo.year)
        UserDefaultsManager.shared.setUserID(to: newUserInfo.id)
        UserDefaultsManager.shared.setUserEmail(to: newUserInfo.email)
    }

    func deleteUser(email: String) {
        provider.request(.deleteUser(email: email)) { result in
            switch result {
            case let .success(response):
                print("Delete: \(response)")
                self.logOutUser(token: self.getAccessToken())
                // Note: didDeleteUser() should call logoutDelegate's didCompleteLogOut()
                self.deleteUserDelegate?.didDeleteUser()
            case let .failure(error):
                print(error)
            }
        }
    }

    //Current User Accesors
    func getUID() -> Int { return currentUser.uID ?? -1 }
    func getEmail() -> String { return currentUser.uEmail }
    func getFirstName() -> String { return currentUser.uFirstName }
    func getLastName() -> String { return currentUser.uLastName }
    func getMajor() -> String { return currentUser.uMajor }
    func getMinor() -> String { return currentUser.uMinor }
    func getYear() -> Int { return currentUser.uYear }
    func getBio() -> String { return currentUser.uBio }
    func getAccessToken() -> String { return currentUser.access_token ?? "" }
}

protocol SignupDelegate {
    func didFinishSignup()
    func signUpFailed(error: String)
}

protocol LoginDelegate {
    func didLogin()
    func loginFailed(error: String)
}

protocol ReadDelegate {
    func didReadUser()
    func readFailed(error: String)
}

protocol LogoutDelegate {
    func didCompleteLogout()
    func logoutFailed()
}

protocol DeleteUserDelegate {
    func didDeleteUser()
}

protocol UpdateDelegate {
    func didUpdateUser()
    func updateFailed(error: String)
}

protocol RefreshDelegate {
    func didRefreshToken()
    func refreshFailed()
    func networkFailure()
}
