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
    private var create_read_update: UserCreate?
    private var login_model: UserLog?
    
    init() {
        user_email = ""
        user_password = ""
        first_name = ""
        last_name = ""
        user_major = ""
        user_minor = ""
        user_year = 0
        user_bio = ""
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
    
    public func getToken() -> String? {
        return login_model?.access_token
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
            return ""
        }
    }

    public func accessUserYear() -> Int {
        return user_year
    }
    
    public func createUser() {
        API.createUser(email: user_email, password: user_password, first_name: first_name, last_name: last_name, major: user_major, minor: user_minor, year: user_year, self_bio: user_bio) { (created_user) in
            self.create_read_update = created_user
        }
    }
    public func loginUser() {
        API.loginUser(username: user_email, password: user_password, grant_type: "password", client_id: CLIENTID, client_secret: CLIENTSECRET) { (logged_user) in
            self.login_model = logged_user
        }
        readUser()
        user_email = create_read_update?.email
        first_name = create_read_update?.first_name
        last_name = create_read_update?.last_name
        user_major = create_read_update?.major
        user_minor = create_read_update?.minor
        user_bio = create_read_update?.self_bio
        user_year = create_read_update?.year

    }
    public func readUser() {
        API.readUsers(email: user_email, access_token: UserDefaults.standard.object(forKey: user_email) as! String) { (sent_user) in
            self.create_read_update = sent_user
        }
    }
    public func updateUser() {
        API.updateUser(email: user_email, password: user_password, first_name: first_name, last_name: last_name, major: user_major, minor: user_minor, year: user_year, self_bio: user_bio, access_token: UserDefaults.standard.object(forKey: user_email) as! String) { (updatedUser) in
            self.create_read_update = updatedUser
        }
    }
    public func deleteUser() {
        API.deleteUser(email: user_email, access_token: UserDefaults.standard.object(forKey: user_email) as! String) {
            print("Deleted User")
        }
    }
    
}
