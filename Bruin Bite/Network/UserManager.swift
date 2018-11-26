//
//  UserManager.swift
//  Bruin Bite
//
//  Created by Samuel J. Lee on 11/16/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

class UserManager {
    static let shared: UserManager = UserManager()
    private var currentUser: UserModel
    //local copy, database -> userdef

    //Delegates
    var signupDelegate: SignupDelegate? = nil // The first signup vc will be this delegate.
    var loginDelegate: LoginDelegate? = nil // Login VC will be this delegate
    var readDelegate: ReadDelegate? = nil //

    //UserDefaults keys
    private var kEmail = "email"
    private var kID = "uid"
    private var kAccessToken = "accessToken"
    private var kRefreshToken = "refreshToken"

    private init() {
        currentUser = UserModel()
    }

    func createUser(email: String, uID: Int) {
        //Make call to create user, if successful
            // add email to userdefaults & uid
            // call didFinishSignUp
        UserDefaults.standard.set(email, forKey: kEmail)
        UserDefaults.standard.set(uID, forKey: kID)
        currentUser.uEmail = email
        currentUser.uID = uID
        //Store email and password in currentUser
        //Login User
    }

    func loginUser(accessToken: String, refreshToken: String) {
        //Make call to log in, if successful
            // add access & refresh token to userdefaults
            // call didLogin
        UserDefaults.standard.set(accessToken, forKey: kAccessToken)
        UserDefaults.standard.set(refreshToken, forKey: kRefreshToken)
        currentUser.access_token = accessToken
        currentUser.refresh_token = refreshToken
        //Store tokens
        //Read User
    }

    func signupScreen1() {
        // update userdefaults & backend with new info
    }

    func signUpScreen2() {
        // update userdefaults & backend with new info
    }

    func readUser() {
        //After reading user, store into currentUser
        //Add parameters to didReadUser so that when you call it
        //you can pass in the new information from currentUser
    }

    func logOutUser() {
        // Should empty out user struct in userdefaults - ESP ACCESS TOKEN & REFRESH TOKEN.
        UserDefaults.standard.removeObject(forKey: kAccessToken)
        UserDefaults.standard.removeObject(forKey: kRefreshToken)
        UserDefaults.standard.removeObject(forKey: kEmail)
        UserDefaults.standard.removeObject(forKey: kID)
        currentUser = UserModel()
        // Calls didCompleteLogout()
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
