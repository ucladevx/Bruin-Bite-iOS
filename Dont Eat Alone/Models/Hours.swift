//
//  HoursAPI.swift
//  Dont Eat Alone
//
//  Created by Kameron Carr on 5/26/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

struct HallHours: Codable {
    let hall_name: String
    let breakfast: String
    let lunch: String
    let dinner: String
    let late_night: String
}

//The JSON data wasn't uniform so I needed optionals but I didn't want to deal with optionals later
struct HallHoursOptional: Codable {
    let hall_name: String
    let breakfast: String?
    let lunch: String?
    let dinner: String?
    let late_night: String?
}

struct DayHours: Codable {
    let hourDate: String
    let hours: [HallHoursOptional]
}

struct AllHours: Codable {
    let hours: [DayHours]
}

