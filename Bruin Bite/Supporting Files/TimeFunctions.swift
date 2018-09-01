//
//  TimeFunctions.swift
//  Bruin Bite
//
//  Created by Samuel J. Lee on 5/30/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

func convertDate(month: String, day: String, year: String) -> String {
    var tempMonth = ""
    tempMonth += year
    tempMonth = tempMonth + "-"
    switch(month) {
    case "Jan":
        tempMonth = tempMonth + "01-" + day
        break
    case "Feb":
        tempMonth = tempMonth + "02-" + day
        break
    case "Mar":
        tempMonth = tempMonth + "03-" + day
        break
    case "Apr":
        tempMonth = tempMonth + "04-" + day
        break
    case "May":
        tempMonth = tempMonth + "05-" + day
        break
    case "Jun":
        tempMonth = tempMonth + "06-" + day
        break
    case "Jul":
        tempMonth = tempMonth + "07-" + day
        break
    case "Aug":
        tempMonth = tempMonth + "08-" + day
        break
    case "Sep":
        tempMonth = tempMonth + "09-" + day
        break
    case "Oct":
        tempMonth = tempMonth + "10-" + day
        break
    case "Nov":
        tempMonth = tempMonth + "11-" + day
        break
    case "Dec":
        tempMonth = tempMonth + "12-" + day
        break
    default:
        break
    }
    return tempMonth
}

func getMonth(dateMonth: String) -> String {
    var temp = ""
    for i in dateMonth {
        if(i == " ") {
            break
        }
        temp += String(i)
    }
    return temp
}

func getDay(date: String) -> String {
    var temp = ""
    var counter = 0
    var check = 0
    for i in date {
        if(i == " " && check == 1) {
            break
        }
        if(counter == 1 && i != ",") {
            if(i == "1" || i == "2" || i == "3" || i == "4" ||
                i == "5" || i == "6" || i == "7" || i == "8" || i == "9") {
                temp += "0" + String(i)
            } else {
                temp += String(i)
            }
        }
        if(i == " ") {
            counter = 1
            check = 1
        }
    }
    Logger.shared.handle(type: .debug, message: temp)
    return temp
}

func getYear(date: String) -> String {
    var temp = ""
    var check = 0
    for i in date {
        if(check == 1 && i != " ") {
            temp += String(i)
        }
        if(i == ",") {
            check = 1
        }
    }
    return temp
}



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
