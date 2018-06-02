//
//  UserClass.swift
//  Dont Eat Alone
//
//  Created by Samuel J. Lee on 5/21/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

public class User {
    
    /* How this works
     I made private member variables for the user that stores email, etc.
     I have functions - initUserError, updateError, changeUserInfo, changeYear, getToken, accessUserInfo, accessUserYear, createUser, loginUser, readUser, updateUser, deleteUser
     
     initUserError - this function is called when in UserAPI, my User struct I'm decoding from cannot find the key so it decodes it into a UserError Decodeable and passes it to initUserError. It calls updateError.
     updateError - based on which error it is, it sets net_error, a String variable that holds the current error, to the error that Terrence sends me
     changeUserInfo - Pass in the type of info you want to change and it will change it
     changeYear - Same as above except with Int
     getToken - accesses the current Token the User is logged in with
     accessUserInfo - takes in a type of user Info wanted and returns it
     accessUserYear - same as above with year
     createUser - Returns a boolean. It attempts to create a user and within createUser of userAPI, I will set user_error_model to the error Terrence sends back if it doesn't work. It will return false if not created, and the error will be stored in net_error, where on the frontend we can display it by accessing through MAIN_USER.accessUserInfo(type: "error")
     loginUser - Attempts to login user and if not logged in, then I will store the error in net_error as well, which I do in UserAPI. In Log in Auth, I check for the auth token and will return if not found. If not found, you can also access the error Terrence sends through net_error
     readUser - same as login User except reads the User and updates creat_read_update
     updateUser - updates the User on the backend by using the current values
     - so If I want to update the profile, I would store the new profile bio into user_bio, then I would just call MAIN_USER.updateUser()
     deleteUser - deletes the user
     */
    private var user_ID: Int
    private var user_email: String
    private var user_password: String
    private var first_name: String
    private var last_name: String
    private var user_major: String
    private var user_minor: String
    private var user_year: Int
    private var user_bio: String
    private var net_error: String
    private var create_read_update: UserCreate?
    private var login_model: UserLog?
    private var user_error_model: UserError?
    
    private var preferred_period: String
    
    init() {
        user_email = ""
        user_password = ""
        first_name = ""
        last_name = ""
        user_major = ""
        user_minor = ""
        user_year = 0
        user_bio = ""
        net_error = ""
        user_ID = -1
        preferred_period = ""
    }
    
    func initUserError (error: UserError) {
        user_error_model = error
        updateError()
    }
    
    func updateError () {
        if((user_error_model?.email ?? nil) != nil) {
            net_error = (user_error_model?.email![0])!
        }
        else if ((user_error_model?.password ?? nil) != nil) {
            net_error = (user_error_model?.password![0])!
        }
        else if ((user_error_model?.error_description ?? nil) != nil) {
            net_error = (user_error_model?.error_description)!
        }
        print(net_error)
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
        case "error":
            net_error = info
            break
        case "period":
            preferred_period = info
            break
        default:
            print("ERROR TYPE INPUT INCORRECT")
        }
    }
    
    public func changeYear(year: Int) {
        user_year = year
    }
    
    public func getToken() -> String? {
        return ((UserDefaults.standard.object(forKey: self.user_email) as? String) ?? nil)
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
        case "error":
            return net_error
        case "period":
            return preferred_period
        default:
            print("ERROR TYPE INPUT INCORRECT")
            return ""
        }
    }
    
    public func accessUserYear() -> Int {
        return self.user_year
    }
    
    public func accessUserId() -> Int {
        return self.user_ID
    }
    
    public func createUser(devid: String) -> Bool {
        print(user_email)
        print(user_password)
        print(first_name)
        print(last_name)
        print(user_major)
        print(user_minor)
        print(user_year)
        print(user_bio)
        print(devid)
        self.user_ID = -2
        API.createUser(email: user_email, password: user_password, first_name: first_name, last_name: last_name, major: user_major, minor: user_minor, year: user_year, self_bio: user_bio, device_id: devid) { (created_user) in
            self.create_read_update = created_user
        }
        if(self.create_read_update != nil) {
            self.user_ID = (self.create_read_update?.id)!
            return true
        } else {
            return false
        }
    }
    
    
    public func loginUser() {
        API.loginUser(username: user_email, password: user_password, grant_type: "password", client_id: CLIENTID, client_secret: CLIENTSECRET) { (logged_user) in
            self.login_model = logged_user
        }
    }
    public func readUser() {
        DispatchQueue.global(qos: .background).async {
            API.readUsers(email: self.user_email, access_token: MAIN_USER.getToken() ?? "") { (sent_user) in
                self.create_read_update = sent_user
                self.user_email = self.create_read_update?.email ?? ""
                self.first_name = self.create_read_update?.first_name ?? ""
                self.last_name = self.create_read_update?.last_name ?? ""
                self.user_major = self.create_read_update?.major ?? ""
                self.user_minor = self.create_read_update?.minor ?? ""
                self.user_bio = self.create_read_update?.self_bio ?? ""
                self.user_year = self.create_read_update?.year ?? 0
                self.user_ID = self.create_read_update?.id ?? 0
            }
        }
    }
    public func updateUser(dev_id: String) {
        DispatchQueue.global(qos: .background).async {
            API.updateUser(email: self.user_email, password: self.user_password, first_name: self.first_name, last_name: self.last_name, major: self.user_major, minor: self.user_minor, year: self.user_year, self_bio: self.user_bio, access_token: UserDefaults.standard.object(forKey: self.user_email) as? String ?? "", device_id: dev_id) { (updatedUser) in
                self.create_read_update = updatedUser
            }
        }
    }
    public func deleteUser() {
        DispatchQueue.global(qos: .background).async {
            API.deleteUser(email: self.user_email, access_token: UserDefaults.standard.object(forKey: self.user_email) as? String ?? "") {
                print("Deleted User")
            }
        }
    }
    
    public func userMatch(mealTimes: [String], mealDay: String, mealPeriod: String, dineHalls: [String]) {
        DispatchQueue.global(qos: .background).async {
            API.matchUser(user: self.user_ID, meal_times: mealTimes, meal_day: mealDay, meal_period: mealPeriod, dining_halls: dineHalls, completion: {
                print("Sent User match")
            })
        }
    }
    
}
