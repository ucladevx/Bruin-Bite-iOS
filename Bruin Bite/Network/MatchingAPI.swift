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
    func didReceiveMatches(requests: [Match])
}

class MatchingAPI {
    private let provider = MoyaProvider<MainAPI>()

    func getRequests(completionDelegate: GetRequestsDelegate, user: Int, status: [String]){
        provider.request(.getRequests(user: user, status: status)) { result in
            switch result{
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([Request].self, from: response.data)
                    let jsonData = JSON(response.data)
                    print(jsonData)
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
                    let jsonData = JSON(response.data)
                    print(jsonData)
                    completionDelegate.didReceiveMatches(requests: results)
                } catch let err{
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }


    //TODO: Currently just test data
    func getSuccessfulMatches(completionHandler: ([SuccessfulMatch])->Void){
        var successfulMatches = [SuccessfulMatch]()
        
        var match = SuccessfulMatch(profilePicture: UIImage(), user: String(), firstName: String(), lastName: String(), diningHall: String(), mealPeriod: String(), chatURL: String(), day: String(), time: String())
        match.user = "User1"
        match.firstName = "Joe"
        match.lastName = "Bruin"
        match.diningHall = "BPlate"
        match.mealPeriod = "Lunch"
        match.day = "15th March, 2019"
        match.time = "1 pm"
        successfulMatches.append(match)
        
        match = SuccessfulMatch(profilePicture: UIImage(), user: String(), firstName: String(), lastName: String(), diningHall: String(), mealPeriod: String(), chatURL: String(), day: String(), time: String())
        match.user = "User2"
        match.firstName = "Hannah"
        match.lastName = "Chen"
        match.diningHall = "Covel"
        match.mealPeriod = "Lunch"
        match.day = "16th March, 2019"
        match.time = "1 pm"
        successfulMatches.append(match)
        
        match = SuccessfulMatch(profilePicture: UIImage(), user: String(), firstName: String(), lastName: String(), diningHall: String(), mealPeriod: String(), chatURL: String(), day: String(), time: String())
        match.user = "User3"
        match.firstName = "Suzzie"
        match.lastName = "Davis"
        match.diningHall = "BPlate"
        match.mealPeriod = "Breakfast"
        match.day = "17th March, 2019"
        match.time = "7 am"
        successfulMatches.append(match)
        
        completionHandler(successfulMatches)
    }

    func getPendingMatches(completionHandler: ([PendingRequest])->Void){
        var pendingMatches = [PendingRequest]()
        
        var match = PendingRequest(diningHall: String(), mealPeriod: String(), day: String(), times: String(), status: String())
        match.diningHall = "BPlate"
        match.mealPeriod = "Dinner"
        match.day = "15th March, 2019"
        match.times = "5 pm - 6 pm"
        match.status = "P"
        pendingMatches.append(match)
        
        match = PendingRequest(diningHall: String(), mealPeriod: String(), day: String(), times: String(), status: String())
        match.diningHall = "BPlate"
        match.mealPeriod = "Breakfast"
        match.day = "16th March, 2019"
        match.times = "7 am - 8:30 am"
        match.status = "P"
        pendingMatches.append(match)
        
        match = PendingRequest(diningHall: String(), mealPeriod: String(), day: String(), times: String(), status: String())
        match.diningHall = "Covel"
        match.mealPeriod = "Dinner"
        match.day = "16th March, 2019"
        match.times = "6:30 pm - 8 pm"
        match.status = "P"
        pendingMatches.append(match)
        
        match = PendingRequest(diningHall: String(), mealPeriod: String(), day: String(), times: String(), status: String())
        match.diningHall = "BPlate"
        match.mealPeriod = "Lunch"
        match.day = "17th March, 2019"
        match.times = "12:30 pm - 1:30 pm"
        match.status = "P"
        pendingMatches.append(match)
        
        match = PendingRequest(diningHall: String(), mealPeriod: String(), day: String(), times: String(), status: String())
        match.diningHall = "FEAST"
        match.mealPeriod = "Dinner"
        match.day = "17th March, 2019"
        match.times = "6 pm - 6:30 pm"
        match.status = "P"
        pendingMatches.append(match)
        
        completionHandler(pendingMatches)
    }
}
