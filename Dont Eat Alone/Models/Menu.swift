//
//  Menu.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 2/19/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

/* Data Structure Tree
 
 Date
 |
 MealPeriod     Location
 |
 [Items]
 |
 Name    Allergens   RecipeLink  Category
 
 */

//---Enums---
enum Allergen{
    case None
    case Vegetarian
    case Vegan
    case ContainsPeanuts
    case ContainsTreeNuts
    case ContainsWheat
    case ContainsSoy
    case ContainsDairy
    case ContainsEggs
    case ContainsShellfish
    case ContainsFish
}

enum MealPeriod: String{
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case lateNight = "Late Night"
    case brunch = "Brunch"
}

enum Location: String{
    case deNeve = "De Neve"
    case covel = "Covel"
    case bPlate = "Bruin Plate"
    case feast = "FEAST at Rieber"
}

//---Structures---
struct Nutrition{
    var label: String
    var amount: String
    var percent: String
}

struct Item{
    var itemCategory: String
    var subLocation: String?
    var name: String
    var serving: String?
    var calories: String?
    var fatcal: String?
    var ingredients: String?
    var vita: String?
    var vitc: String?
    var calc: String?
    var iron: String?
    var allergies: [Allergen]?
    var nutrition: [Nutrition]?
    var recipeLink: String?
}

//menus at all the locations for a meal period
struct Menu{
    var date: String
    var overviewData: [MealPeriod: [Location: [Item]]]
    var detailedData: [MealPeriod: [Location: [Item]]]
}

class MenuController{
    
    var menus: [Menu] = []
    
    func getOverviewMenu(date: String, mealPeriod: MealPeriod) -> [Location:[Item]]?{
        for menu in menus{
            let index = menu.date.index(menu.date.endIndex, offsetBy: -2)
            let sub = menu.date[index...]
            if(sub == date){
                return menu.overviewData[mealPeriod]
            }
        }
        return nil
    }
    
    func getDetailedMenu(date: String, mealPeriod: MealPeriod) -> [Location:[Item]]?{
        for menu in menus{
            let index = menu.date.index(menu.date.endIndex, offsetBy: -2)
            let sub = menu.date[index...]
            if(sub == date){
                return menu.overviewData[mealPeriod]
            }
        }
        return nil
    }
    
    //test data
    var itemA1 = Item(itemCategory: "Overview", subLocation: "Bakery", name: "Cheese Blintz w/ Berry Compote", serving: "1 serving", calories: "400", fatcal: "100", ingredients: "Yogurt and berries", vita: "10%", vitc: "20%", calc: "30%", iron: "40%", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], nutrition: [Nutrition(label: "Protein", amount: "10", percent: "10%")], recipeLink: nil)
    var itemA2 = Item(itemCategory: "Overview", subLocation: "Bakery", name: "Cheese Blintz w/ Berry Compote 3", serving: "1 serving", calories: "400", fatcal: "100", ingredients: "Yogurt and berries", vita: "10%", vitc: "20%", calc: "30%", iron: "40%", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], nutrition: [Nutrition(label: "Protein", amount: "10", percent: "10%")], recipeLink: nil)
    var itemA3 = Item(itemCategory: "Overview", subLocation: "Bakery", name: "Cheese Blintz w/ Berry Compote 3", serving: "1 serving", calories: "400", fatcal: "100", ingredients: "Yogurt and berries", vita: "10%", vitc: "20%", calc: "30%", iron: "40%", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], nutrition: [Nutrition(label: "Protein", amount: "10", percent: "10%")], recipeLink: nil)
    var itemA4 = Item(itemCategory: "Overview", subLocation: "Bakery", name: "Cheese Blintz w/ Berry Compote 4", serving: "1 serving", calories: "400", fatcal: "100", ingredients: "Yogurt and berries", vita: "10%", vitc: "20%", calc: "30%", iron: "40%", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], nutrition: [Nutrition(label: "Protein", amount: "10", percent: "10%")], recipeLink: nil)
    
    init() {
//        self.menus.append(Menu(date: "03-03-1028", overviewData: [MealPeriod.breakfast:[Location.bPlate:[itemA1,itemA2,itemA3,itemA4]]], detailedData: [:]))
	}
}
