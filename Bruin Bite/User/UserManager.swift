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

    //Delegates
    var signupDelegate: SignupDelegate? = nil
    var loginDelegate: LoginDelegate? = nil

    private init() {
        currentUser = UserModel()
    }

    func createUser() {
        //Make call to create user, if successful call didFinishSignUp
        //Store email and password in currentUser
        //Login User
    }

    func loginUser() {
        //Make call to log in, if successful call didLogin
        //Store tokens
        //Read User
    }
}

protocol SignupDelegate { func didFinishSignup() }

protocol LoginDelegate { func didLogin() }
