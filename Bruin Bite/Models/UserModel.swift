//
//  UserModel.swift
//  Bruin Bite
//
//  Created by Samuel J. Lee on 11/16/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

struct UserModel {
    var uID: Int?
    var uEmail: String

    // Tokens
    var access_token: String?
    var refresh_token: String?

    // User Information
    var uFirstName: String
    var uLastName: String
    var uMajor: String
    var uMinor: String
    var uYear: Int
    var uBio: String

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
