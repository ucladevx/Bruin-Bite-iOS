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
struct Item{
    var itemCategory: String //also includes overview menu
    var name: String
    var allergies: [Allergen]
    var recipeLink: String?
    //add nutrition here later
}

//menus at all the locations for a meal period
struct Menu{
    var mealPeriod: MealPeriod
    var overviewData: [Location: [Item]]
    var fullData: [Location: [Item]]
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
            if menu.mealPeriod == mealPeriod{
                return menu.overviewData[location]
            }
        }
        return nil
    }
    
    func getFullMenu(mealPeriod: MealPeriod, location: Location) -> [Item]?{
        for menu in menus{
            if menu.mealPeriod == mealPeriod{
                return menu.fullData[location]
            }
        }
        return nil
    }
    
    //test data
    var itemA1 = Item(itemCategory: "Overview", name: "Cheese Blintz w/ Berry 1", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], recipeLink: nil)
    var itemA2 = Item(itemCategory: "Overview", name: "Cheese Blintz w/ Berry 2", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], recipeLink: nil)
    var itemA3 = Item(itemCategory: "Overview", name: "Cheese Blintz w/ Berry 3", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], recipeLink: nil)
    var itemA4 = Item(itemCategory: "Overview", name: "Cheese Blintz w/ Berry 4", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], recipeLink: nil)
    
    init() {
        self.menus.append(Menu(mealPeriod: MealPeriod.breakfast, overviewData: [Location.bPlate: [self.itemA1, self.itemA2, self.itemA3, self.itemA4]], fullData: [:]))
    }
}



//Menu
//  -minimized menu items
//  -get activity levels
//  -get times
//  -
