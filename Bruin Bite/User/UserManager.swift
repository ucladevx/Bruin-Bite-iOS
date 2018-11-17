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
    var signupDelegate: SignupDelegate? = nil
    private var currentUser: UserModel
    private init() {
        currentUser = UserModel()
    }

    func createUser() {
        //Make call to create user, if successful call didFinishSignUp
        //Store email and password in currentUser
    }
}

protocol SignupDelegate {
    func didFinishSignup()
}
