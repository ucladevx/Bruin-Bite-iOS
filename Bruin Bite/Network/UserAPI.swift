//
//  UserAPI.swift
//  Dont Eat Alone
//
//  Created by Samuel J. Lee on 5/8/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import SwiftyJSON
import Result

protocol MatchDelegate {
    func didReceiveMatch(withID id: Int)
}

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
                        Logger.log("createUser failed with error: \(err)", withLevel: .error)
                    } catch let reserr {
                        Logger.log("createUser failed with error: \(reserr)", withLevel: .error)
                    }
                }
            case let .failure(error):
                Logger.log("createUser failed with error: \(error)", withLevel: .error)
            }
        }
    }
    
    static func loginUser(username: String, password: String, grant_type: String, client_id: String, client_secret: String, completion: @escaping (UserLog) -> ()) {
        provider.request(.loginUser(username:username, password: password, grant_type: grant_type, client_id: client_id, client_secret: client_secret)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(UserLog.self, from: response.data)
                    UserDefaults.standard.set(username, forKey: "email")
                    UserDefaults.standard.set(results.access_token, forKey: "accessToken")
                    UserDefaults.standard.set(results.refresh_token, forKey: "refreshToken")
                    completion(results)
                } catch let err {
                    do {
                        let errresults = try JSONDecoder().decode(UserError.self, from: response.data)
                        UserDefaults.standard.set(nil, forKey: "accessToken")
                        UserDefaults.standard.set(nil, forKey: "refreshToken")
                        MAIN_USER.initUserError(error: errresults)
                        Logger.log("loginUser failed with error: \(err)", withLevel: .error)
                    } catch let reserr {
                        UserDefaults.standard.set(nil, forKey: "accessToken")
                        UserDefaults.standard.set(nil, forKey: "refreshToken")
                        Logger.log("loginUser failed with error: \(reserr)", withLevel: .error)
                    }
                }            case let .failure(error):
                    UserDefaults.standard.set(nil, forKey: "accessToken")
                    UserDefaults.standard.set(nil, forKey: "refreshToken")
                    Logger.log("loginUser failed with error: \(error)", withLevel: .error)
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
                        Logger.log("Could not read user: \(err)", withLevel: .warning)
                    } catch let reserr {
                        Logger.log("Could not read user: \(reserr)", withLevel: .warning)
                    }
                }
            case let .failure(error):
                Logger.log("Could not read user: \(error)", withLevel: .warning)
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
                        Logger.log("updateUser failed with error: \(err)", withLevel: .error)
                    } catch let reserr {
                        Logger.log("updateUser failed with error: \(reserr)", withLevel: .error)
                    }
                }
            case let .failure(error):
                Logger.log("updateUser failed with error: \(error)", withLevel: .error)
            }
        }
    }
    
    static func deleteUser(email: String, access_token: String, completion: @escaping () -> Void) {
        provider.request(.deleteUser(email:email, access_token: access_token)) { result in
            switch result {
            case let .success(response):
                Logger.log("User Deleted: \(response)", withLevel: .info)
                completion()
            case let .failure(error):
                Logger.log("Could not delete User: \(error)", withLevel: .error)
            }
            UserDefaults.standard.removeObject(forKey: email)
        }
    }
    
    static func matchUser(completionDelegate: MatchDelegate, user: Int, meal_times: [String], meal_day: String, meal_period: String, dining_halls: [String], completion: @escaping() -> Void) {
        provider.request(.matchUser(user: user, meal_times: meal_times, meal_day: meal_day, meal_period: meal_period, dining_halls: dining_halls)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MatchRequestData.self, from: response.data)
                    let jsonData = JSON(response.data)
                    Logger.log("matchUser JSON data: \(jsonData)", withLevel: .debug)
                    let matchID = results.id
                    completionDelegate.didReceiveMatch(withID: matchID)
                    Logger.log("matchUser results: \(results)", withLevel: .debug)
                } catch let err {
                    Logger.log("matchUser failed with error: \(err)", withLevel: .error)
                }
                Logger.log("Successfully Sent match", withLevel: .info)
            case let .failure(error):
                Logger.log("matchUser failed with error: \(error)", withLevel: .error)
            }
        }
    }
}

