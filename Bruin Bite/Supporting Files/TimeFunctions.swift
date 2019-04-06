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
    print(temp)
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
    return "1:00"
}
