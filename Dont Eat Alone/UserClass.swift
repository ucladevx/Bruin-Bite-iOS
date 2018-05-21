//
//  UserClass.swift
//  Dont Eat Alone
//
//  Created by Samuel J. Lee on 5/21/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

public class User {
    private var user_email: String
    private var user_password: String
    private var first_name: String
    private var last_name: String
    private var user_major: String
    private var user_minor: String
    private var user_year: Int
    private var user_bio: String
    
    init(email: String, password: String, firstname: String, lastname: String, major: String, minor: String, year: Int, bio: String) {
        user_email = email
        user_password = password
        first_name = firstname
        last_name = lastname
        user_major = major
        user_minor = minor
        user_year = year
        user_bio = bio
    }
    
    public func changeUserInfo(type: String, info: String) {
        switch (type) {
        case "email":
            user_email = info
            break
        case "password":
            user_password = info
            break
        case "first":
            first_name = info
            break
        case "last":
            last_name = info
            break
        case "major":
            user_major = info
            break
        case "minor":
            user_minor = info
            break
        case "bio":
            user_bio = info
            break
        default:
            print("ERROR TYPE INPUT INCORRECT")
        }
    }
    
    public func changeYear(year: Int) {
        user_year = year
    }
    
    public func accessUserInfo(type: String) -> String {
        switch (type) {
        case "email":
            return user_email
        case "password":
            return user_password
        case "first":
            return first_name
        case "last":
            return last_name
        case "major":
            return user_major
        case "minor":
            return user_minor
        case "bio":
            return user_bio
        default:
            print("ERROR TYPE INPUT INCORRECT")
        }
    }

    public func accessUserYear() -> Int {
        return user_year
    }
    
}
