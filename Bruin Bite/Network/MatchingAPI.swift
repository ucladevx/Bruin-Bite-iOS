//
//  MatchingAPI.swift
//  Bruin Bite
//
//  Created by Kameron Carr on 3/9/19.
//  Copyright © 2019 Dont Eat Alone. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Moya

protocol GetRequestsDelegate {
    func didReceiveRequests(requests: [Request])
}
protocol GetMatchesDelegate {
    func didReceiveMatches(matches: [Match])
}
protocol MatchRequestDelegate {
    func matchRequestSent(successfully: Bool)
    func matchRequestDuplicate()
}
protocol GetUserDelegate {
    func didReceiveUser(userData: UserCreate)
}

class MatchingAPI {
    private let provider = MoyaProvider<MainAPI>()

    func getRequests(completionDelegate: GetRequestsDelegate, user: Int, status: [String]){
        provider.request(.getRequests(user: user, status: status)) { result in
            switch result{
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([Request].self, from: response.data)
                    completionDelegate.didReceiveRequests(requests: results)
                } catch let err{
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getMatches(completionDelegate: GetMatchesDelegate, user: Int){
        provider.request(.getMatches(user: user)) { result in
            switch result{
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([Match].self, from: response.data)
                    completionDelegate.didReceiveMatches(matches: results)
                } catch let err{
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func matchUser(completionDelegate: MatchRequestDelegate?, user: Int, meal_times: [String], meal_day: String, meal_period: String, dining_halls: [String]) {
        provider.request(.matchUser(user: user, meal_times: meal_times, meal_day: meal_day, meal_period: meal_period, dining_halls: dining_halls)) { result in
            switch result {
            case let .success(response):
                guard response.statusCode != 400 else {
                    completionDelegate?.matchRequestSent(successfully: false)
                    return
                }
                guard response.statusCode != 409 else {
                    completionDelegate?.matchRequestDuplicate()
                    return
                }

                do {
                    let results = try JSONDecoder().decode(MatchRequestData.self, from: response.data)
                    completionDelegate?.matchRequestSent(successfully: true)
                    print (results)
                } catch let err {
                    completionDelegate?.matchRequestSent(successfully: false)
                    print(err)
                }
            case let .failure(error):
                if error.response?.statusCode == 418 {
                    completionDelegate?.matchRequestDuplicate()
                } else {
                    completionDelegate?.matchRequestSent(successfully: false)
                }
                print(error)
            }
        }
    }
    
    func getUserById(completionDelegate: GetUserDelegate?, id: Int){
        provider.request(.readUserById(id: String(id))) { result in
            switch result {
            case let .success(response):
                do{
                    let resultStruct = try JSONDecoder().decode(UserCreate.self, from: response.data)
                    completionDelegate?.didReceiveUser(userData: resultStruct)
                } catch let err {
                    print ("Error parsing response JSON into UserModel struct")
                    print (err)
                }
            case let .failure(error):
                print("Error retrieving user")
                print(error.errorDescription ?? "")
            }
        }
    }
}
