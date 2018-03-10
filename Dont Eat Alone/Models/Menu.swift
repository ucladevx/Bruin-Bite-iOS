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
    case feast = "Feast at Reiber"
}

//---Structures---
struct Nutrition{
    var label: String
    var amount: String
    var percent: String
}

struct Item{
    var itemCategory: String
    var name: String
    var serving: String
    var calories: String
    var fatcal: String
    var ingredients: String
    var vita: String
    var vitc: String
    var calc: String
    var iron: String
    var allergies: [Allergen]
    var nutrition: [Nutrition]
    var recipeLink: String?
}

//menus at all the locations for a meal period
struct Menu{
    var overviewData: [MealPeriod: [Location: [Item]]]
    var fullData: [MealPeriod: [Location: [Item]]]
}

class MenuController{
    
    var menus: [Menu] = []
    
    
    //func getActivityLevel() ->
    //func getOverviewMenu() ->
    //func getFullMenu() ->
    //func getItemDetails() ->
    //func getTime() ->
    
    func getOverviewMenu(mealPeriod: MealPeriod, location: Location) -> [Item]?{
        for menu in menus{
            menu.overviewData[mealPeriod[location]]
        }
        return nil
    }
    
    func getFullMenu(mealPeriod: MealPeriod, location: Location) -> [Item]?{
        for menu in menus{
            menu.fullData[mealPeriod[location]]
        }
        return nil
    }
    
    //test data
    var itemA1 = Item(itemCategory: "Overview", name: "Cheese Blintz w/ Berry Compote", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], recipeLink: nil)
    var itemA2 = Item(itemCategory: "Overview", name: "Cheese Blintz w/ Berry 2", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], recipeLink: nil)
    var itemA3 = Item(itemCategory: "Overview", name: "Cheese Blintz w/ Berry 3", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], recipeLink: nil)
    var itemA4 = Item(itemCategory: "Overview", name: "Cheese Blintz w/ Berry 4", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], recipeLink: nil)
    
    init() {
        self.menus.append(Menu(mealPeriod: MealPeriod.breakfast, overviewData: [Location.bPlate: [self.itemA1, self.itemA2, self.itemA3, self.itemA4]], fullData: [:]))
    }
}
