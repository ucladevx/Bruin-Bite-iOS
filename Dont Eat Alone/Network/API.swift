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
                    for(id) in data{
                        var currMenu = Menu
                        let overview = id["overviewMenu"]
                        var parsedMeal: [MealPeriod: [Location: [Item]]]
                        for (time, meal) in overview{
                            var parsedLocation: [Location: [Item]]
                            for (location, items) in meal{
                                var parsedItems = [Item]()
                                for(sublocation, itemsList) in items{
                                    for item in itemsList{
                                        var currItem = Item()
                                        currItem.itemCategory = sublocation
                                        currItem.name = item["name"]
                                        currItem.recipeLink = item["recipelink"]
                                        var allergens = [Allergen]()
                                        if (item["itemcodes"].isEmpty){
                                            allergens.append(Allergen.None)
                                        }
                                        else{
                                            for a in item["itemcodes"]{
                                                switch a{
                                                case "V":
                                                    allergens.append(Allergen.Vegetarian)
                                                    break;
                                                case "VG":
                                                    allergens.append(Allergen.Vegan)
                                                    break;
                                                case "APNT":
                                                    allergens.append(Allergen.ContainsPeanuts)
                                                    break;
                                                case "ATNT":
                                                    allergens.append(Allergen.ContainsTreeNuts)
                                                    break;
                                                case "AWHT":
                                                    allergens.append(Allergen.ContainsWheat)
                                                    break;
                                                case "ASOY":
                                                    allergens.append(Allergen.ContainsSoy)
                                                    break;
                                                case "AMLK":
                                                    allergens.append(Allergen.ContainsDairy)
                                                    break;
                                                case "AEGG":
                                                    allergens.append(Allergen.ContainsEggs)
                                                    break;
                                                case "ACSF":
                                                    allergens.append(Allergen.ContainsShellfish)
                                                    break;
                                                case "AFSH":
                                                    allergens.append(Allergen.ContainsFish)
                                                    break;
                                                }
                                            }
                                        }
                                        currItem.allergies = allergens
                                        currItem.serving = item["nutrition"]["serving_size"]
                                        currItem.calories = item["nutrition"]["Calories"]
                                        currItem.fatcal = item["nutrition"]["Fat_Cal."]
                                        currItem.ingredients = item["nutrition"]["ingredients"]
                                        currItem.vita = item["nutrition"]["Vitamin A"]
                                        currItem.vitc = item["nutrition"]["Vitamin C"]
                                        currItem.calc = item["nutrition"]["Calcium"]
                                        currItem.iron = item["nutrition"]["Iron"]
                                        var nutrition = [Nutrition]()
                                        for i in 3..<12{
                                            var nut = Nutrition()
                                            nut.label = item["nutrition"][i]
                                            nut.amount = item["nutrition"][i][0]
                                            nut.percent = item["nutrition"][i][1]
                                            nutrition.append(nut)
                                        }
                                        currItem.nutrition = nutrition
                                        parsedItems.append(currItem)
                                    }
                                }
                                parsedLocation.append(location:parsedItems)
                            }
                            parsedMeal.append(time:parsedLocation)
                        }
                        currMenu.overviewData = parsedMeal
                        menus.append(currMenu)
                    }
                    completion(Menu)
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
                    //use swifyJSON to simplift the JSON
                    let json = try JSON(data: response.data)
                    let data = json["level"][0]["level"]
                    
                    var activityLevels = [ActivityLevel]()
                    
                    for (name, value) in data{
                        var activityLevel = ActivityLevel()
                        let value = String(describing: value)
                        var percentage = 0

                        if value == "-1%"{
                            activityLevel.isAvailable = false
                        }
                        else{
 
                            let index = value.index(value.endIndex, offsetBy: -1)
                            percentage = Int(value[..<index])!
                            activityLevel.isAvailable = true
                        }
                        
                        switch name{
                        case "Covel":
                            activityLevel.data = [.covel : percentage]
                            break
                        case "De Neve":
                            activityLevel.data = [.deNeve : percentage]
                            break
                        case "Bruin Plate":
                            activityLevel.data = [.bPlate : percentage]
                            break
                        case "FEAST at Rieber":
                            activityLevel.data = [.feast : percentage]
                            break
                        default:
                            activityLevel.isAvailable = false
                            break
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
