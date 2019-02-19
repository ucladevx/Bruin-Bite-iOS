//
//  TimeFunctions.swift
//  Bruin Bite
//
//  Created by Samuel J. Lee on 5/30/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

func timeForm(time: String) -> String {
    switch(time) {
    case "1:00":
        return "13:00"
    case "1:15":
        return "13:15"
    case "1:30":
        return "13:30"
    case "1:45":
        return "13:45"
    case "2:00":
        return "14:00"
    case "2:15":
        return "14:15"
    case "2:30":
        return "14:30"
    case "2:45":
        return "14:45"
    case "3:00":
        return "15:00"
    case "4:15":
        return "16:15"
    case "4:30":
        return "16:30"
    case "4:45":
        return "16:45"
    case "5:00":
        return "17:00"
    case "5:15":
        return "17:15"
    case "5:30":
        return "17:30"
    case "5:45":
        return "17:45"
    case "6:00":
        return "18:00"
    case "6:15":
        return "18:15"
    case "6:30":
        return "18:30"
    case "6:45":
        return "18:45"
    case "7:00":
        return "19:00"
    case "7:15":
        return "19:15"
    case "7:30":
        return "19:30"
    case "7:45":
        return "19:45"
    case "8:00":
        return "20:00"
    case "9:00":
        return "21:00"
    case "9:15":
        return "21:15"
    case "9:30":
        return "21:30"
    case "9:45":
        return "21:45"
    case "10:00":
        return "22:00"
    case "10:15":
        return "22:15"
    case "10:30":
        return "22:30"
    case "10:45":
        return "22:45"
    case "11:00":
        return "23:00"
    case "11:15":
        if(MAIN_USER.accessUserInfo(type: "period") != "LU") {
            return "23:15"
        } else {
            return "11:15"
        }
    case "11:30":
        if(MAIN_USER.accessUserInfo(type: "period") != "LU") {
            return "23:30"
        } else {
            return "11:30"
        }
    case "11:45":
        if(MAIN_USER.accessUserInfo(type: "period") != "LU") {
            return "23:45"
        } else {
            return "11:45"
        }
    case "12:00":
        if(MAIN_USER.accessUserInfo(type: "period") != "LU") {
            return "24:00"
        } else {
            return "12:00"
        }
    case "12:15":
        if(MAIN_USER.accessUserInfo(type: "period") != "LU") {
            return "24:15"
        } else {
            return "12:15"
        }
    case "12:30":
        if(MAIN_USER.accessUserInfo(type: "period") != "LU") {
            return "24:30"
        } else {
            return "12:30"
        }
    case "12:45":
        if(MAIN_USER.accessUserInfo(type: "period") != "LU") {
            return "24:45"
        } else {
            return "12:45"
        }
    default:
        return time
    }
}
