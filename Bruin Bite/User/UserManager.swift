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
    var readDelegate: ReadDelegate? = nil

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

    func readUser() {
        //After reading user, store into currentUser
        //Add parameters to didReadUser so that when you call it
        //you can pass in the new information from currentUser
    }
}

protocol SignupDelegate { func didFinishSignup() }

protocol LoginDelegate { func didLogin() }

protocol ReadDelegate { func didReadUser() }
