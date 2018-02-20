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
                  MealPeriod
                      |
                  Location
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
    case bPlate = "BPlate"
    case feast = "Feast"
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
    var data: [Location: [Item]]
}

class MenuController{
    
    var menu: Menu?
    
    
    
    //test data
    var itemA1 = Item(itemCategory: "Overview", name: "Cheese Blintz w/ Berry Compote", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], recipeLink: nil)
    var itemA2 = Item(itemCategory: "Overview", name: "Cheese Blintz w/ Berry Compote", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], recipeLink: nil)
    var itemA3 = Item(itemCategory: "Overview", name: "Cheese Blintz w/ Berry Compote", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], recipeLink: nil)
    var itemA4 = Item(itemCategory: "Overview", name: "Cheese Blintz w/ Berry Compote", allergies: [Allergen.Vegan, Allergen.ContainsEggs, Allergen.ContainsWheat, Allergen.ContainsSoy], recipeLink: nil)
    
    init() {
        self.menu = Menu(mealPeriod: MealPeriod.breakfast, data: [Location.bPlate: [self.itemA1, self.itemA2, self.itemA3, self.itemA4]])
    }
}
    
    
    
    //Menu
    //  -minimized menu items
    //  -get activity levels
    //  -get times
    //  -
