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
enum Allergens{
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
    var itemCategory: String
    var name: String
    var allergies: [Allergens]
    var recipeLink: String?
    //add nutrition here later
}

var data = [Location: [Item]]()

struct Menu{
    var mealPeriod: MealPeriod
    var location: Location
    var item: Item
}

class MenuController{
    var abc: String
    init(abc: String){
        self.abc = abc
    }
    
    //Menu
    //  -minimized menu items
    //  -get activity levels
    //  -get times
    //  -
}
