//
//  UserAPI.swift
//  Dont Eat Alone
//
//  Created by Samuel J. Lee on 5/8/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import Result

extension API {
    
    static let UserAPIKey = "myKey"
    
    static func createUser(email: String, password: String, first_name: String, last_name: String, major: String, minor: String, year: Int, self_bio: String, device_id: String, completion: @escaping (UserCreate) -> ()) {
        provider.request(.createUser(email: email, password: password, first_name: first_name, last_name: last_name, major: major, minor: minor, year: year, self_bio: self_bio, device_id: device_id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(UserCreate.self, from: response.data)
                    completion(results)
                } catch let err {
                    do {
                        let errresults = try JSONDecoder().decode(UserError.self, from: response.data)
                        MAIN_USER.initUserError(error: errresults)
                        print(err)
                    } catch let reserr {
                        print(reserr)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func loginUser(username: String, password: String, grant_type: String, client_id: String, client_secret: String, completion: @escaping (UserLog) -> ()) {
        provider.request(.loginUser(username:username, password: password, grant_type: grant_type, client_id: client_id, client_secret: client_secret)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(UserLog.self, from: response.data)
                    UserDefaults.standard.set(results.access_token, forKey: MAIN_USER.accessUserInfo(type: "email"))
                    completion(results)
                } catch let err {
                    do {
                        let errresults = try JSONDecoder().decode(UserError.self, from: response.data)
                        MAIN_USER.initUserError(error: errresults)
                        print(err)
                    } catch let reserr {
                        print(reserr)
                    }
                }            case let .failure(error):
                print(error)
            }
            
        }
    }
    
    static func readUsers(email: String, access_token: String, completion: @escaping (UserCreate) -> ()) {
        API.provider.request(.readUsers(email: email, access_token: access_token)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(UserCreate.self, from: response.data)
                    completion(results)
                } catch let err {
                    do {
                        let errresults = try JSONDecoder().decode(UserError.self, from: response.data)
                        MAIN_USER.initUserError(error: errresults)
                        print(err)
                    } catch let reserr {
                        print(reserr)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func updateUser(email: String, password: String, first_name: String, last_name: String, major: String, minor: String, year: Int, self_bio: String, access_token: String, device_id: String, completion: @escaping (UserCreate) -> ()) {
        provider.request(.updateUser(email: email, password: password, first_name: first_name, last_name: last_name, major: major, minor: minor, year: year, self_bio: self_bio, access_token: access_token, device_id: device_id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(UserCreate.self, from: response.data)
                    completion(results)
                } catch let err {
                    do {
                    let errresults = try JSONDecoder().decode(UserError.self, from: response.data)
                    MAIN_USER.initUserError(error: errresults)
                    print(err)
                    } catch let reserr {
                        print(reserr)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func deleteUser(email: String, access_token: String, completion: @escaping () -> Void) {
        provider.request(.deleteUser(email:email, access_token: access_token)) { result in
            switch result {
            case let .success(response):
                print("Delete: \(response)")
                completion()
            case let .failure(error):
                print(error)
            }
            UserDefaults.standard.removeObject(forKey: email)
        }
    }
    
    static func matchUser(user: Int, meal_times: [String], meal_day: String, meal_period: String, dining_halls: [String], completion: @escaping() -> Void) {
        provider.request(.matchUser(user: user, meal_times: meal_times, meal_day: meal_day, meal_period: meal_period, dining_halls: dining_halls)) { result in
            switch result {
            case let .success(response):
                print("Successfully Sent match")
            case let .failure(error):
                print(error)
            }
            
        }
    }
    
}

