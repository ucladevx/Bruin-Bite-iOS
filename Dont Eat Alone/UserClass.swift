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
    }
    public func readUser() {
<<<<<<< HEAD
        /*
        DispatchQueue.global(qos: .background).async {
            API.readUsers(email: self.user_email, access_token: MAIN_USER.getToken()!) { (sent_user) in
                self.create_read_update = sent_user
                self.user_email = self.create_read_update?.email ?? ""
                self.first_name = self.create_read_update?.first_name ?? ""
                self.last_name = self.create_read_update?.last_name ?? ""
                self.user_major = self.create_read_update?.major ?? ""
                self.user_minor = self.create_read_update?.minor ?? ""
                self.user_bio = self.create_read_update?.self_bio ?? ""
                self.user_year = self.create_read_update?.year ?? 0
            }
        }*/
=======
//        DispatchQueue.global(qos: .background).async {
//            API.readUsers(email: self.user_email, access_token: MAIN_USER.getToken()!) { (sent_user) in
//                self.create_read_update = sent_user
//                self.user_email = self.create_read_update?.email ?? ""
//                self.first_name = self.create_read_update?.first_name ?? ""
//                self.last_name = self.create_read_update?.last_name ?? ""
//                self.user_major = self.create_read_update?.major ?? ""
//                self.user_minor = self.create_read_update?.minor ?? ""
//                self.user_bio = self.create_read_update?.self_bio ?? ""
//                self.user_year = self.create_read_update?.year ?? 0
//            }
//        }
>>>>>>> 9f2e02588a4dd0ef7facfe78f14ac8ca2b3ad9f8
    }
    public func updateUser() {
        DispatchQueue.global(qos: .background).async {
            API.updateUser(email: self.user_email, password: self.user_password, first_name: self.first_name, last_name: self.last_name, major: self.user_major, minor: self.user_minor, year: self.user_year, self_bio: self.user_bio, access_token: UserDefaults.standard.object(forKey: self.user_email) as! String) { (updatedUser) in
                self.create_read_update = updatedUser
            }
        }
    }
    public func deleteUser() {
        DispatchQueue.global(qos: .background).async {
            API.deleteUser(email: self.user_email, access_token: UserDefaults.standard.object(forKey: self.user_email) as! String) {
                print("Deleted User")
            }
        }
    }
    
}
