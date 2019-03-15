//
//  MatchingAPI.swift
//  Bruin Bite
//
//  Created by Kameron Carr on 3/9/19.
//  Copyright © 2019 Dont Eat Alone. All rights reserved.
//

import Foundation
import UIKit
func getSuccessfulMatches(completionHandler: ([SuccessfulMatch])->Void){
    var successfulMatches = [SuccessfulMatch]()
    for i in 1...4 {
        var match = SuccessfulMatch(profilePicture: UIImage(), user: String(), firstName: String(), lastName: String(), diningHall: String(), mealPeriod: String(), chatURL: String(), day: String(), time: String())
        match.user = "User" + "\(i)"
        match.firstName = "FN" + "\(i)"
        match.lastName = "LN" + "\(i)"
        match.diningHall = "BP"
        match.mealPeriod = "DI"
        match.day = "15th March, 2019"
        match.time = "\(i+4) pm"
        successfulMatches.append(match)
    }
    completionHandler(successfulMatches)
}

func getPendingMatches(completionHandler: ([PendingMatch])->Void){
    var pendingMatches = [PendingMatch]()
    for i in 1...5 {
        var match = PendingMatch(diningHall: String(), mealPeriod: String(), day: String(), times: String(), status: String())
        match.diningHall = "BP"
        match.mealPeriod = "DI"
        match.day = "15th March, 2019"
        match.times = "\(i) pm - \(i+2) pm"
        match.status = "P"
        pendingMatches.append(match)
    }
    completionHandler(pendingMatches)
}
