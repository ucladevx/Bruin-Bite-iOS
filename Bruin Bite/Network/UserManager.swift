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
    //local copy, database -> userdef

    //Delegates
    var signupDelegate: SignupDelegate? = nil // The first signup vc will be this delegate.
    var loginDelegate: LoginDelegate? = nil // Login VC will be this delegate
    var readDelegate: ReadDelegate? = nil
    var logoutDelegate: LogoutDelegate? = nil
    var deleteUserDelegate: DeleteUserDelegate? = nil

    //UserDefaults keys
    private var email_KEY = "Email"
    private var id_KEY = "U_ID"
    private var accessToken_KEY = "Access_Token"
    private var refreshToken_KEY = "Refresh_Token"
    private var firstName_KEY = "First_Name"
    private var lastName_KEY = "Last_Name"
    private var major_KEY = "Major"
    private var minor_KEY = "Minor"
    private var year_KEY = "Year"
    private var selfBio_KEY = "Self_Bio"

    private init() {
        currentUser = UserModel()
    }

    func createUser(email: String, password: String) {
        provider.request(.createUser(email: email, password: password, is_active: true)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(UserCreate.self, from: response.data)
                    UserDefaults.standard.set(results.email, forKey: self.email_KEY)
                    UserDefaults.standard.set(results.id, forKey: self.id_KEY)
                    self.currentUser.uEmail = results.email
                    self.currentUser.uID = results.id
                    self.signupDelegate?.didFinishSignup()
                } catch let err {
                    //implement err catch
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
        //Make call to create user, if successful
            // add email to userdefaults & uid
            // call didFinishSignUp
        //Store email in currentUser
    }

    func loginUser(email: String, password: String) {
        provider.request(.loginUser(username: email, password: password, grant_type: "password", client_id: CLIENTID, client_secret: CLIENTSECRET)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(UserLog.self, from: response.data)
                    UserDefaults.standard.set(results.access_token, forKey: self.accessToken_KEY)
                    UserDefaults.standard.set(results.refresh_token, forKey: self.refreshToken_KEY)
                    self.currentUser.access_token = results.access_token
                    self.currentUser.refresh_token = results.refresh_token
                    self.loginDelegate?.didLogin()
                } catch let err {
                    print(err)
                    //handle error
                }
            case let .failure(error):
                print(error)
            }
        }
        //Make call to log in, if successful
            // add access & refresh token to userdefaults
            // call didLogin
        //Store tokens
    }

    func signupScreen1() {
        // update userdefaults & backend with new info
    }

    func signUpScreen2() {
        // update userdefaults & backend with new info
    }

    func readUser(email: String) {
        provider.request(.readUser(email: email)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(UserCreate.self, from: response.data)
                    self.updateCurrentUser(newUserInfo: results)
                    self.readDelegate?.didReadUser()
                } catch let err {
                    print(err)
                    //handle error
                }
            case let .failure(error):
                print(error)
            }
        }
        //After reading user, store into currentUser
        //Add parameters to didReadUser so that when you call it
        //you can pass in the new information from currentUser
    }

    func updateCurrentUser(newUserInfo: UserCreate) {
        self.currentUser.uBio = newUserInfo.self_bio
        self.currentUser.uFirstName = newUserInfo.first_name
        self.currentUser.uLastName = newUserInfo.last_name
        self.currentUser.uMajor = newUserInfo.major
        self.currentUser.uMinor = newUserInfo.minor
        self.currentUser.uYear = newUserInfo.year
        UserDefaults.standard.set(newUserInfo.self_bio, forKey: selfBio_KEY)
        UserDefaults.standard.set(newUserInfo.first_name, forKey: firstName_KEY)
        UserDefaults.standard.set(newUserInfo.last_name, forKey: lastName_KEY)
        UserDefaults.standard.set(newUserInfo.major, forKey: major_KEY)
        UserDefaults.standard.set(newUserInfo.minor, forKey: minor_KEY)
        UserDefaults.standard.set(newUserInfo.year, forKey: year_KEY)
    }

    func logOutUser() {
        UserDefaults.standard.removeObject(forKey: accessToken_KEY)
        UserDefaults.standard.removeObject(forKey: refreshToken_KEY)
        UserDefaults.standard.removeObject(forKey: email_KEY)
        UserDefaults.standard.removeObject(forKey: id_KEY)
        currentUser = UserModel()
        logoutDelegate?.didCompleteLogout()
    }

    func deleteUser(email: String) {
        provider.request(.deleteUser(email: email)) { result in
            switch result {
            case let .success(response):
                print("Delete: \(response)")
                self.logOutUser()
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
}

protocol LoginDelegate {
    func didLogin()
}

protocol ReadDelegate {
    func didReadUser()
}

protocol LogoutDelegate {
    func didCompleteLogout()
}

protocol DeleteUserDelegate {
    func didDeleteUser()
}
