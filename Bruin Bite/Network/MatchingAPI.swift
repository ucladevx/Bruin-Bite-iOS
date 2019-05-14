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


    //TODO: Currently just test data
    func getTestMatches(completionHandler: GetMatchesDelegate){
        var matches = [Match]()
        
        var match = Match(user1: 1, user2: 2, user1_first_name: String(), user2_first_name: String(), user1_last_name: String(), user2_last_name: String(), meal_datetime: String(), meal_period: String(), dining_hall: String(), chat_url: String())
        match.user1_first_name = "Joe"
        match.user1_last_name = "Bruin"
        match.user2_first_name = "Jocie"
        match.user2_last_name = "Bruin"
        match.meal_datetime = ""
        match.meal_period = "LU"
        match.dining_hall = "FE"
        match.chat_url = "/users/messaging"
        matches.append(match)
        
        match = Match(user1: 1, user2: 2, user1_first_name: String(), user2_first_name: String(), user1_last_name: String(), user2_last_name: String(), meal_datetime: String(), meal_period: String(), dining_hall: String(), chat_url: String())
        match.user1_first_name = "Joe"
        match.user1_last_name = "Bruin"
        match.user2_first_name = "Jay"
        match.user2_last_name = "Bruin"
        match.meal_datetime = ""
        match.meal_period = "DI"
        match.dining_hall = "BP"
        match.chat_url = "/users/messaging"
        matches.append(match)
        
        match = Match(user1: 1, user2: 2, user1_first_name: String(), user2_first_name: String(), user1_last_name: String(), user2_last_name: String(), meal_datetime: String(), meal_period: String(), dining_hall: String(), chat_url: String())
        match.user1_first_name = "Joe"
        match.user1_last_name = "Bruin"
        match.user2_first_name = "Michelle"
        match.user2_last_name = "Obama"
        match.meal_datetime = ""
        match.meal_period = "BU"
        match.dining_hall = "CO"
        match.chat_url = "/users/messaging"
        matches.append(match)
        
        completionHandler.didReceiveMatches(matches: matches)
    }

    func getTestRequests(completionHandler: GetRequestsDelegate){
        var requests = [Request]()
        
        var request = Request(user: 1, meal_times: [String()], meal_day: String(), meal_period: String(), dining_hall: String(), status: String())
        request.meal_times = [""]
        request.meal_day = ""
        request.meal_period = "BR"
        request.dining_hall = "DN"
        request.status = "P"
        requests.append(request)
        
        request = Request(user: 1, meal_times: [String()], meal_day: String(), meal_period: String(), dining_hall: String(), status: String())
        request.meal_times = [""]
        request.meal_day = ""
        request.meal_period = "LU"
        request.dining_hall = "BP"
        request.status = "P"
        requests.append(request)
        
        request = Request(user: 1, meal_times: [String()], meal_day: String(), meal_period: String(), dining_hall: String(), status: String())
        request.meal_times = [""]
        request.meal_day = ""
        request.meal_period = "DI"
        request.dining_hall = "FE"
        request.status = "T"
        requests.append(request)
        
        request = Request(user: 1, meal_times: [String()], meal_day: String(), meal_period: String(), dining_hall: String(), status: String())
        request.meal_times = [""]
        request.meal_day = ""
        request.meal_period = "LU"
        request.dining_hall = "BP"
        request.status = "S"
        requests.append(request)
        
        completionHandler.didReceiveRequests(requests: requests)
    }
}
