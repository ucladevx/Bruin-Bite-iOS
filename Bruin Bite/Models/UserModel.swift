//
//  UserModel.swift
//  Bruin Bite
//
//  Created by Samuel J. Lee on 11/16/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

struct UserModel {
    private var uID: Int?
    private var uEmail: String

    // Tokens
    private var access_token: String?
    private var refresh_token: String?

    // User Information
    private var uFirstName: String
    private var uLastName: String
    private var uMajor: String
    private var uMinor: String
    private var uYear: Int
    private var uBio: String

    init() {
        uEmail = ""
        uFirstName = ""
        uLastName = ""
        uMajor = ""
        uMinor = ""
        uYear = 0
        uBio = ""
    }
}
