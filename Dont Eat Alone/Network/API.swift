//
//  API.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 3/1/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

class API{
    static let provider = MoyaProvider<MenuAPI>()
    
    static func getOverviewMenu(completion: @escaping ([Menu])->()){
        provider.request(.getOverviewMenu) { result in
            switch result{
            case let .success(response):
                do{
                    let json = try JSON(data: response.data)
                    let data = json["menus"]
                    var menus = [Menu]()
                    for(_, menu) in data{
                        var currMenu = Menu(date: "", overviewData: [:], detailedData: [:])
                        currMenu.date = menu["menuDate"].stringValue
                        let overview = menu["overviewMenu"]
                        var parsedMeal: [MealPeriod: [Location: [Item]]] = [:]
                        var brunch = false
                        for (time, meal) in overview{
                            var parsedLocation: [Location: [Item]] = [:]
                            var mealPeriod: MealPeriod = MealPeriod.breakfast
                            switch(time){ // sets mealPeriod based on input, accounts for brunch
                            case "breakfast":
                                mealPeriod = MealPeriod.breakfast
                                if (meal.isEmpty){
                                    brunch = true
                                    continue
                                }
                                break
                            case "lunch":
                                mealPeriod = MealPeriod.lunch
                                if(brunch){
                                    mealPeriod = MealPeriod.brunch
                                }
                                break
                            case "dinner":
                                mealPeriod = MealPeriod.dinner
                                break
                            default:
                                break
                            }
                            for (location, items) in meal{
                                var parsedItems = [Item]()
                                for(sublocation, itemsList) in items{
                                    for (_,item) in itemsList{
                                        var currItem = Item(itemCategory: "Overview", subLocation: "", name: "", serving: nil, calories: nil, fatcal: nil, ingredients: nil, vita: nil, vitc: nil, calc: nil, iron: nil, allergies: nil, nutrition: nil, recipeLink: nil)
                                        currItem.subLocation = sublocation
                                        currItem.name = item["name"].string!
                                        currItem.recipeLink = item["recipelink"].string
                                        var allergens = [Allergen]()
                                        if (item["itemcodes"].isEmpty){ // checks for Allergens
                                            allergens.append(Allergen.None)
                                        }
                                        else{
                                            for (a,_) in item["itemcodes"]{
                                                switch a{
                                                case "V":
                                                    allergens.append(Allergen.Vegetarian)
                                                    break
                                                case "VG":
                                                    allergens.append(Allergen.Vegan)
                                                    break
                                                case "APNT":
                                                    allergens.append(Allergen.ContainsPeanuts)
                                                    break
                                                case "ATNT":
                                                    allergens.append(Allergen.ContainsTreeNuts)
                                                    break
                                                case "AWHT":
                                                    allergens.append(Allergen.ContainsWheat)
                                                    break
                                                case "ASOY":
                                                    allergens.append(Allergen.ContainsSoy)
                                                    break
                                                case "AMLK":
                                                    allergens.append(Allergen.ContainsDairy)
                                                    break
                                                case "AEGG":
                                                    allergens.append(Allergen.ContainsEggs)
                                                    break
                                                case "ACSF":
                                                    allergens.append(Allergen.ContainsShellfish)
                                                    break
                                                case "AFSH":
                                                    allergens.append(Allergen.ContainsFish)
                                                    break
                                                default:
                                                    break;
                                                }
                                            }
                                        }
                                        currItem.allergies = allergens
                                        if (!item["nutrition"].isEmpty){
                                            currItem.serving = item["nutrition"]["serving_size"].string!
                                            currItem.calories = item["nutrition"]["Calories"].string!
                                            currItem.fatcal = item["nutrition"]["Fat_Cal."].string!
                                            currItem.ingredients = item["nutrition"]["ingredients"].string!
                                            currItem.vita = item["nutrition"]["Vitamin A"].string!
                                            currItem.vitc = item["nutrition"]["Vitamin C"].string!
                                            currItem.calc = item["nutrition"]["Calcium"].string!
                                            currItem.iron = item["nutrition"]["Iron"].string!
                                            var nutrition = [Nutrition]()
                                            for (label,info) in item["nutrition"]{ // adds nutrients with daily values
                                                switch label{
                                                case "Total_Fat", "Saturated_Fat", "Trans_Fat", "Cholesterol", "Sodium", "Total_Carbohydrate", "Dietary_Fiber", "Sugars", "Protein":
                                                    var nut = Nutrition(label: "", amount: "", percent: "")
                                                    nut.label = label
                                                    nut.amount = info[0].string!
                                                    nut.percent = info[1].string!
                                                    nutrition.append(nut)
                                                    break
                                                default:
                                                    break
                                                }
                                            }
                                            currItem.nutrition = nutrition
                                        }
                                        parsedItems.append(currItem)
                                        
                                    }
                                }
                                parsedLocation[Location(rawValue: location)!] = parsedItems
                            }
                            parsedMeal[mealPeriod] = parsedLocation
                        }
                        currMenu.overviewData = parsedMeal
                        menus.append(currMenu)
                    }
                    completion(menus)
                }
                catch{
                    print("error parsing")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func getDetailedMenu(completion: @escaping ([Menu])->()){
        provider.request(.getDetailedMenu) { result in
            switch result{
            case let .success(response):
                do{
                    let json = try JSON(data: response.data)
                    let data = json["menus"]
                    var menus = [Menu]()
                    for(_, menu) in data{
                        var currMenu = Menu(date: "", overviewData: [:], detailedData: [:])
                        currMenu.date = menu["menuDate"].stringValue
                        let overview = menu["detailedMenu"]
                        var parsedMeal: [MealPeriod: [Location: [Item]]] = [:]
                        var brunch = false
                        for (time, meal) in overview{
                            var parsedLocation: [Location: [Item]] = [:]
                            var mealPeriod: MealPeriod = MealPeriod.breakfast
                            switch(time){ // sets mealPeriod based on input, accounts for brunch
                            case "breakfast":
                                mealPeriod = MealPeriod.breakfast
                                if (meal.isEmpty){
                                    brunch = true
                                    continue
                                }
                                break
                            case "lunch":
                                mealPeriod = MealPeriod.lunch
                                if(brunch){
                                    mealPeriod = MealPeriod.brunch
                                }
                                break
                            case "dinner":
                                mealPeriod = MealPeriod.dinner
                                break
                            default:
                                break
                            }
                            for (location, items) in meal{
                                var parsedItems = [Item]()
                                for(sublocation, itemsList) in items{
                                    for (_,item) in itemsList{
                                        var currItem = Item(itemCategory: "Detailed", subLocation: "", name: "", serving: nil, calories: nil, fatcal: nil, ingredients: nil, vita: nil, vitc: nil, calc: nil, iron: nil, allergies: nil, nutrition: nil, recipeLink: nil)
                                        currItem.subLocation = sublocation
                                        currItem.name = item["name"].string!
                                        currItem.recipeLink = item["recipelink"].string
                                        var allergens = [Allergen]()
                                        if (item["itemcodes"].isEmpty){ // checks for Allergens
                                            allergens.append(Allergen.None)
                                        }
                                        else{
                                            for (a,_) in item["itemcodes"]{
                                                switch a{
                                                case "V":
                                                    allergens.append(Allergen.Vegetarian)
                                                    break
                                                case "VG":
                                                    allergens.append(Allergen.Vegan)
                                                    break
                                                case "APNT":
                                                    allergens.append(Allergen.ContainsPeanuts)
                                                    break
                                                case "ATNT":
                                                    allergens.append(Allergen.ContainsTreeNuts)
                                                    break
                                                case "AWHT":
                                                    allergens.append(Allergen.ContainsWheat)
                                                    break
                                                case "ASOY":
                                                    allergens.append(Allergen.ContainsSoy)
                                                    break
                                                case "AMLK":
                                                    allergens.append(Allergen.ContainsDairy)
                                                    break
                                                case "AEGG":
                                                    allergens.append(Allergen.ContainsEggs)
                                                    break
                                                case "ACSF":
                                                    allergens.append(Allergen.ContainsShellfish)
                                                    break
                                                case "AFSH":
                                                    allergens.append(Allergen.ContainsFish)
                                                    break
                                                default:
                                                    break;
                                                }
                                            }
                                        }
                                        currItem.allergies = allergens
                                        if (!item["nutrition"].isEmpty){
                                            currItem.serving = item["nutrition"]["serving_size"].string!
                                            currItem.calories = item["nutrition"]["Calories"].string!
                                            currItem.fatcal = item["nutrition"]["Fat_Cal."].string!
                                            currItem.ingredients = item["nutrition"]["ingredients"].string!
                                            currItem.vita = item["nutrition"]["Vitamin A"].string!
                                            currItem.vitc = item["nutrition"]["Vitamin C"].string!
                                            currItem.calc = item["nutrition"]["Calcium"].string!
                                            currItem.iron = item["nutrition"]["Iron"].string!
                                            var nutrition = [Nutrition]()
                                            for (label,info) in item["nutrition"]{ // adds nutrients with daily values
                                                switch label{
                                                case "Total_Fat", "Saturated_Fat", "Trans_Fat", "Cholesterol", "Sodium", "Total_Carbohydrate", "Dietary_Fiber", "Sugars", "Protein":
                                                    var nut = Nutrition(label: "", amount: "", percent: "")
                                                    nut.label = label
                                                    nut.amount = info[0].string!
                                                    nut.percent = info[1].string!
                                                    nutrition.append(nut)
                                                    break
                                                default:
                                                    break
                                                }
                                            }
                                            currItem.nutrition = nutrition
                                        }
                                        parsedItems.append(currItem)
                                        
                                    }
                                }
                                parsedLocation[Location(rawValue: location)!] = parsedItems
                            }
                            parsedMeal[mealPeriod] = parsedLocation
                        }
                        currMenu.detailedData = parsedMeal
                        menus.append(currMenu)
                    }
                    completion(menus)
                }
                catch{
                    print("error parsing")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func getCurrentActivityLevels(completion: @escaping ([ActivityLevel])->()){
        provider.request(.getCurrentActivityLevels) { result in
            switch result{
            case let .success(response):
                do{
                    //use swifyJSON to simplify the JSON
                    let json = try JSON(data: response.data)
                    let data = json["level"]
                    
                    var activityLevels = [ActivityLevel]()
                    
                    for (name, value) in data{
                        var activityLevel = ActivityLevel(isAvailable: false, location: nil, percent: 0)
                        let value = String(describing: value)
                        var percentage = 0
                        activityLevel.location = Location(rawValue: name)!
                        if value == "-1%"{
                            activityLevel.isAvailable = false
                        }
                        else{
                            let index = value.index(value.endIndex, offsetBy: -1)
                            percentage = Int(value[..<index])!
                            activityLevel.isAvailable = true
                            activityLevel.percent = percentage
                        }
                        activityLevels.append(activityLevel)
                    }
                    completion(activityLevels)
                }
                catch{
                    print("error parsing")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
