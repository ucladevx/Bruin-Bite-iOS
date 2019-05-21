//
//  MatchRequest.swift
//  Bruin Bite
//
//  Created by Kameron Carr on 3/9/19.
//  Copyright © 2019 Dont Eat Alone. All rights reserved.
//

import Foundation
import UIKit

struct Request: Codable{
    var user: Int
    var meal_times: [String]
    var meal_day: String
    var meal_period: String
    var dining_halls: [String]
    var status: String
    
    enum CodingKeys: String, CodingKey {
        case user, meal_times, meal_day, meal_period, dining_halls, status
    }
}

struct Match: Codable{
    var user1: Int
    var user2: Int
    var user1_first_name: String
    var user2_first_name: String
    var user1_last_name: String
    var user2_last_name: String
    var meal_datetime: String
    var meal_period: String
    var dining_hall: String
    var chat_url: String
    
    enum CodingKeys: String, CodingKey {
        case user1, user2, user1_first_name, user2_first_name, user1_last_name, user2_last_name, meal_datetime, meal_period, dining_hall, chat_url
    }
}
