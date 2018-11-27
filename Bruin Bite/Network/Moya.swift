//
//  APIService.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 3/1/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import Moya

enum MainAPI {
    case getCurrentActivityLevels
    case getOverviewMenu
    case getDetailedMenu
    case getHours
    case createUser(email: String, password: String, is_active: Bool)
    case readUser(email: String)
    case loginUser(username:String, password: String, grant_type: String, client_id: String, client_secret: String)
    case updateUser(email: String, password: String, first_name: String, last_name: String, major: String, minor: String, year: Int, self_bio: String) //send it as it is if it hasn't changed
    case deleteUser(email: String)
    case matchUser(user: Int, meal_times: [String], meal_day: String, meal_period: String, dining_halls: [String])
}

extension MainAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .getCurrentActivityLevels, .getOverviewMenu, .getDetailedMenu, .getHours:
            return URL(string: "https://api.bruin-bite.com/api/v1")!
        case .createUser, .readUser, .loginUser, .updateUser, .deleteUser, .matchUser:
            return URL(string: "https://api.bruin-bite.com/api/v1")!
        }
        
    }
    var path: String{
        switch self{
        case .getCurrentActivityLevels:
            return "/menu/ActivityLevels"
        case .getOverviewMenu:
            return "/menu/OverviewMenu"
        case .getDetailedMenu:
            return "/menu/DetailedMenu"
        case .getHours:
            return "/menu/Hours"
        case .createUser:
            return "/users/sign_up/"
        case .loginUser:
            return "/users/o/token/"
        case .readUser, .updateUser, .deleteUser:
            return "/users/data/"
        case .matchUser:
            return "/users/matching/new/"
        }
        
    }
    var method: Moya.Method {
        switch self {
        case .getCurrentActivityLevels, .getOverviewMenu, .getDetailedMenu, .getHours, .readUser:
            return .get
        case .createUser, .loginUser, .matchUser:
            return .post
        case .updateUser:
            return .put
        case .deleteUser:
            return .delete
        }
    }
    var task: Task{
        switch self {
        case .getCurrentActivityLevels, .getOverviewMenu, .getDetailedMenu, .getHours:
            return .requestPlain
        case .createUser(let email, let password, let is_active):
            return .requestParameters(parameters: ["email": email, "password": password, "is_active": is_active], encoding: JSONEncoding.default)
        case .loginUser(let username, let password, let grant_type, let client_id, let client_secret):
            return .requestParameters(parameters: ["username": username, "password": password, "grant_type": grant_type, "client_id": client_id, "client_secret": client_secret], encoding: URLEncoding.default)
        case .readUser(let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.queryString)
        case .updateUser(let email, let password, let first_name, let last_name, let major, let minor, let year, let self_bio):
            return .requestParameters(parameters: ["email": email, "password": password, "first_name": first_name, "last_name": last_name, "major": major, "minor": minor, "year": year, "self_bio": self_bio], encoding: JSONEncoding.default)
        case .deleteUser(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        case .matchUser(let user, let meal_times, let meal_day, let meal_period, let dining_halls):
            return .requestParameters(parameters: ["user": user, "meal_times": meal_times, "meal_day": meal_day, "meal_period": meal_period, "dining_halls": dining_halls], encoding: JSONEncoding.default)
        }
    }
    //for testing
    var sampleData: Data {
        switch self {
        case .getCurrentActivityLevels:
            return "{\"level\":{\"Covel\":\"16%\",\"De Neve\":\"29%\",\"FEAST at Rieber\":\"30%\",\"Bruin Plate\":\"35%\"},\"deletedAt\":null,\"createdAt\":\"2018-03-01T19:32:02.658Z\",\"updatedAt\":\"2018-03-01T19:32:02.658Z\"}]}".utf8Encoded
            
        case .getOverviewMenu:
            return "{\"menus\":[{\"id\":2,\"overviewMenu\":\"{\"breakfast\":{\"De Neve\":{\"Flex Bar\":[{\"name\":\"Chilaquiles Con Huevo\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/140128/2\",\"itemcodes\":{\"V\":\"Vegetarian_Menu_Option\",\"AMLK\":\"Contains_Dairy\",\"AEGG\":\"Contains_Eggs\",\"AWHT\":\"Contains_Wheat\"},\"nutrition\":{\"serving_size\":\"Serving Size 2 oz\",\"Calories\":\"116\",\"Fat_Cal.\":\"60\",\"Total_Fat\":[\"6.7g\",\"10%\"],\"Saturated_Fat\":[\"1.8g\",\"9%\"],\"Trans_Fat\":[\"0.1g\",\"-1\"],\"Cholesterol\":[\"32.8mg\",\"11%\"],\"Sodium\":[\"150.2mg\",\"6%\"],\"Total_Carbohydrate\":[\"10.4g\",\"8%\"],\"Dietary_Fiber\":[\"2.1g\",\"8%\"],\"Sugars\":[\"0.3g\",\"-1\"],\"Protein\":[\"4.3g\",\"-1\"],\"Vitamin A\":\"9%\",\"Vitamin C\":\"1%\",\"Calcium\":\"6%\",\"Iron\":\"11%\",\"ingredients\":\"Enchilada Sauce (Water, Flour, Dry Guajillo Chili Pepper, Olive Oil Blend, Garlic, Sea Salt), Tortilla Chips (White Corn Tortilla, Oil), Refried Beans (Water, Pinto Beans, Olive Oil Blend, Onion, Garlic, Jalapeño Peppers, Sea Salt, Pepper), Eggs, Jack Cheese, Olive Oil Blend\"}}]},\"Bruin Plate\":{\"Freshly Bowled\":[{\"name\":\"Egg White\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/061005/1\",\"itemcodes\":{\"V\":\"Vegetarian_Menu_Option\",\"AEGG\":\"Contains_Eggs\"},\"nutrition\":{\"serving_size\":\"Serving Size 1 each\",\"Calories\":\"40\",\"Fat_Cal.\":\"0\",\"Total_Fat\":[\"0g\",\"0%\"],\"Saturated_Fat\":[\"0g\",\"0%\"],\"Trans_Fat\":[\"0g\",\"-1\"],\"Cholesterol\":[\"0mg\",\"0%\"],\"Sodium\":[\"134.4mg\",\"6%\"],\"Total_Carbohydrate\":[\"0.9g\",\"1%\"],\"Dietary_Fiber\":[\"0g\",\"0%\"],\"Sugars\":[\"-1\",\"-1\"],\"Protein\":[\"8.3g\",\"-1\"],\"Vitamin A\":\"0%\",\"Vitamin C\":\"0%\",\"Calcium\":\"1%\",\"Iron\":\"0%\",\"ingredients\":\"Egg Whites\"}}]}},\"lunch\":{\"Covel\":{\"Exhibition Kitchen\":[{\"name\":\"Build-Your-Own Pasta Bar\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/999070/1\",\"itemcodes\":{},\"nutrition\":{\"serving_size\":\"\",\"ingredients\":\"\"}}],\"Euro Kitchen\":[{\"name\":\"Beef & Lamb Gyro\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/075000/1\",\"itemcodes\":{\"AMLK\":\"Contains_Dairy\",\"AWHT\":\"Contains_Wheat\",\"ASOY\":\"Contains_Soy\"},\"nutrition\":{\"serving_size\":\"Serving Size 1 each\",\"Calories\":\"473\",\"Fat_Cal.\":\"263\",\"Total_Fat\":[\"29.2g\",\"45%\"],\"Saturated_Fat\":[\"11.5g\",\"58%\"],\"Trans_Fat\":[\"0g\",\"-1\"],\"Cholesterol\":[\"57.3mg\",\"19%\"],\"Sodium\":[\"977.4mg\",\"41%\"],\"Total_Carbohydrate\":[\"32.9g\",\"25%\"],\"Dietary_Fiber\":[\"1g\",\"4%\"],\"Sugars\":[\"1.6g\",\"-1\"],\"Protein\":[\"17.6g\",\"-1\"],\"Vitamin A\":\"0%\",\"Vitamin C\":\"0%\",\"Calcium\":\"7%\",\"Iron\":\"16%\",\"ingredients\":\"Beef & Lamb Gyros, Pita Bread\"}}]},\"Bruin Plate\":{\"Freshly Bowled\":[{\"name\":\"Egg White\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/061005/1\",\"itemcodes\":{\"V\":\"Vegetarian_Menu_Option\",\"AEGG\":\"Contains_Eggs\"},\"nutrition\":{\"serving_size\":\"Serving Size 1 each\",\"Calories\":\"40\",\"Fat_Cal.\":\"0\",\"Total_Fat\":[\"0g\",\"0%\"],\"Saturated_Fat\":[\"0g\",\"0%\"],\"Trans_Fat\":[\"0g\",\"-1\"],\"Cholesterol\":[\"0mg\",\"0%\"],\"Sodium\":[\"134.4mg\",\"6%\"],\"Total_Carbohydrate\":[\"0.9g\",\"1%\"],\"Dietary_Fiber\":[\"0g\",\"0%\"],\"Sugars\":[\"-1\",\"-1\"],\"Protein\":[\"8.3g\",\"-1\"],\"Vitamin A\":\"0%\",\"Vitamin C\":\"0%\",\"Calcium\":\"1%\",\"Iron\":\"0%\",\"ingredients\":\"Egg Whites\"}}]}}}\",\"deletedAt\":null,\"menuDate\":\"2018-03-05\",\"createdAt\":\"2018-03-04T08:02:22.066Z\",\"updatedAt\":\"2018-03-04T08:02:22.066Z\"},{\"id\":3,\"overviewMenu\":\"{\"breakfast\":{\"De Neve\":{\"Flex Bar\":[{\"name\":\"Chilaquiles Con Huevo\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/140128/2\",\"itemcodes\":{\"V\":\"Vegetarian_Menu_Option\",\"AMLK\":\"Contains_Dairy\",\"AEGG\":\"Contains_Eggs\",\"AWHT\":\"Contains_Wheat\"},\"nutrition\":{\"serving_size\":\"Serving Size 2 oz\",\"Calories\":\"116\",\"Fat_Cal.\":\"60\",\"Total_Fat\":[\"6.7g\",\"10%\"],\"Saturated_Fat\":[\"1.8g\",\"9%\"],\"Trans_Fat\":[\"0.1g\",\"-1\"],\"Cholesterol\":[\"32.8mg\",\"11%\"],\"Sodium\":[\"150.2mg\",\"6%\"],\"Total_Carbohydrate\":[\"10.4g\",\"8%\"],\"Dietary_Fiber\":[\"2.1g\",\"8%\"],\"Sugars\":[\"0.3g\",\"-1\"],\"Protein\":[\"4.3g\",\"-1\"],\"Vitamin A\":\"9%\",\"Vitamin C\":\"1%\",\"Calcium\":\"6%\",\"Iron\":\"11%\",\"ingredients\":\"Enchilada Sauce (Water, Flour, Dry Guajillo Chili Pepper, Olive Oil Blend, Garlic, Sea Salt), Tortilla Chips (White Corn Tortilla, Oil), Refried Beans (Water, Pinto Beans, Olive Oil Blend, Onion, Garlic, Jalapeño Peppers, Sea Salt, Pepper), Eggs, Jack Cheese, Olive Oil Blend\"}}]},\"Bruin Plate\":{\"Freshly Bowled\":[{\"name\":\"Egg White\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/061005/1\",\"itemcodes\":{\"V\":\"Vegetarian_Menu_Option\",\"AEGG\":\"Contains_Eggs\"},\"nutrition\":{\"serving_size\":\"Serving Size 1 each\",\"Calories\":\"40\",\"Fat_Cal.\":\"0\",\"Total_Fat\":[\"0g\",\"0%\"],\"Saturated_Fat\":[\"0g\",\"0%\"],\"Trans_Fat\":[\"0g\",\"-1\"],\"Cholesterol\":[\"0mg\",\"0%\"],\"Sodium\":[\"134.4mg\",\"6%\"],\"Total_Carbohydrate\":[\"0.9g\",\"1%\"],\"Dietary_Fiber\":[\"0g\",\"0%\"],\"Sugars\":[\"-1\",\"-1\"],\"Protein\":[\"8.3g\",\"-1\"],\"Vitamin A\":\"0%\",\"Vitamin C\":\"0%\",\"Calcium\":\"1%\",\"Iron\":\"0%\",\"ingredients\":\"Egg Whites\"}}]}},\"lunch\":{\"Covel\":{\"Exhibition Kitchen\":[{\"name\":\"Build-Your-Own Pasta Bar\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/999070/1\",\"itemcodes\":{},\"nutrition\":{\"serving_size\":\"\",\"ingredients\":\"\"}}],\"Euro Kitchen\":[{\"name\":\"Beef & Lamb Gyro\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/075000/1\",\"itemcodes\":{\"AMLK\":\"Contains_Dairy\",\"AWHT\":\"Contains_Wheat\",\"ASOY\":\"Contains_Soy\"},\"nutrition\":{\"serving_size\":\"Serving Size 1 each\",\"Calories\":\"473\",\"Fat_Cal.\":\"263\",\"Total_Fat\":[\"29.2g\",\"45%\"],\"Saturated_Fat\":[\"11.5g\",\"58%\"],\"Trans_Fat\":[\"0g\",\"-1\"],\"Cholesterol\":[\"57.3mg\",\"19%\"],\"Sodium\":[\"977.4mg\",\"41%\"],\"Total_Carbohydrate\":[\"32.9g\",\"25%\"],\"Dietary_Fiber\":[\"1g\",\"4%\"],\"Sugars\":[\"1.6g\",\"-1\"],\"Protein\":[\"17.6g\",\"-1\"],\"Vitamin A\":\"0%\",\"Vitamin C\":\"0%\",\"Calcium\":\"7%\",\"Iron\":\"16%\",\"ingredients\":\"Beef & Lamb Gyros, Pita Bread\"}}]},\"Bruin Plate\":{\"Freshly Bowled\":[{\"name\":\"Egg White\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/061005/1\",\"itemcodes\":{\"V\":\"Vegetarian_Menu_Option\",\"AEGG\":\"Contains_Eggs\"},\"nutrition\":{\"serving_size\":\"Serving Size 1 each\",\"Calories\":\"40\",\"Fat_Cal.\":\"0\",\"Total_Fat\":[\"0g\",\"0%\"],\"Saturated_Fat\":[\"0g\",\"0%\"],\"Trans_Fat\":[\"0g\",\"-1\"],\"Cholesterol\":[\"0mg\",\"0%\"],\"Sodium\":[\"134.4mg\",\"6%\"],\"Total_Carbohydrate\":[\"0.9g\",\"1%\"],\"Dietary_Fiber\":[\"0g\",\"0%\"],\"Sugars\":[\"-1\",\"-1\"],\"Protein\":[\"8.3g\",\"-1\"],\"Vitamin A\":\"0%\",\"Vitamin C\":\"0%\",\"Calcium\":\"1%\",\"Iron\":\"0%\",\"ingredients\":\"Egg Whites\"}}]}}}\",\"deletedAt\":null,\"menuDate\":\"2018-03-06\",\"createdAt\":\"2018-03-04T08:02:22.066Z\",\"updatedAt\":\"2018-03-04T08:02:22.066Z\"}]}".utf8Encoded
            
        case .getDetailedMenu:
            return "{\"menus\":[{\"id\":2,\"overviewMenu\":\"{\"breakfast\":{\"De Neve\":{\"Flex Bar\":[{\"name\":\"Chilaquiles Con Huevo\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/140128/2\",\"itemcodes\":{\"V\":\"Vegetarian_Menu_Option\",\"AMLK\":\"Contains_Dairy\",\"AEGG\":\"Contains_Eggs\",\"AWHT\":\"Contains_Wheat\"},\"nutrition\":{\"serving_size\":\"Serving Size 2 oz\",\"Calories\":\"116\",\"Fat_Cal.\":\"60\",\"Total_Fat\":[\"6.7g\",\"10%\"],\"Saturated_Fat\":[\"1.8g\",\"9%\"],\"Trans_Fat\":[\"0.1g\",\"-1\"],\"Cholesterol\":[\"32.8mg\",\"11%\"],\"Sodium\":[\"150.2mg\",\"6%\"],\"Total_Carbohydrate\":[\"10.4g\",\"8%\"],\"Dietary_Fiber\":[\"2.1g\",\"8%\"],\"Sugars\":[\"0.3g\",\"-1\"],\"Protein\":[\"4.3g\",\"-1\"],\"Vitamin A\":\"9%\",\"Vitamin C\":\"1%\",\"Calcium\":\"6%\",\"Iron\":\"11%\",\"ingredients\":\"Enchilada Sauce (Water, Flour, Dry Guajillo Chili Pepper, Olive Oil Blend, Garlic, Sea Salt), Tortilla Chips (White Corn Tortilla, Oil), Refried Beans (Water, Pinto Beans, Olive Oil Blend, Onion, Garlic, Jalapeño Peppers, Sea Salt, Pepper), Eggs, Jack Cheese, Olive Oil Blend\"}}]},\"Bruin Plate\":{\"Freshly Bowled\":[{\"name\":\"Egg White\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/061005/1\",\"itemcodes\":{\"V\":\"Vegetarian_Menu_Option\",\"AEGG\":\"Contains_Eggs\"},\"nutrition\":{\"serving_size\":\"Serving Size 1 each\",\"Calories\":\"40\",\"Fat_Cal.\":\"0\",\"Total_Fat\":[\"0g\",\"0%\"],\"Saturated_Fat\":[\"0g\",\"0%\"],\"Trans_Fat\":[\"0g\",\"-1\"],\"Cholesterol\":[\"0mg\",\"0%\"],\"Sodium\":[\"134.4mg\",\"6%\"],\"Total_Carbohydrate\":[\"0.9g\",\"1%\"],\"Dietary_Fiber\":[\"0g\",\"0%\"],\"Sugars\":[\"-1\",\"-1\"],\"Protein\":[\"8.3g\",\"-1\"],\"Vitamin A\":\"0%\",\"Vitamin C\":\"0%\",\"Calcium\":\"1%\",\"Iron\":\"0%\",\"ingredients\":\"Egg Whites\"}}]}},\"lunch\":{\"Covel\":{\"Exhibition Kitchen\":[{\"name\":\"Build-Your-Own Pasta Bar\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/999070/1\",\"itemcodes\":{},\"nutrition\":{\"serving_size\":\"\",\"ingredients\":\"\"}}],\"Euro Kitchen\":[{\"name\":\"Beef & Lamb Gyro\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/075000/1\",\"itemcodes\":{\"AMLK\":\"Contains_Dairy\",\"AWHT\":\"Contains_Wheat\",\"ASOY\":\"Contains_Soy\"},\"nutrition\":{\"serving_size\":\"Serving Size 1 each\",\"Calories\":\"473\",\"Fat_Cal.\":\"263\",\"Total_Fat\":[\"29.2g\",\"45%\"],\"Saturated_Fat\":[\"11.5g\",\"58%\"],\"Trans_Fat\":[\"0g\",\"-1\"],\"Cholesterol\":[\"57.3mg\",\"19%\"],\"Sodium\":[\"977.4mg\",\"41%\"],\"Total_Carbohydrate\":[\"32.9g\",\"25%\"],\"Dietary_Fiber\":[\"1g\",\"4%\"],\"Sugars\":[\"1.6g\",\"-1\"],\"Protein\":[\"17.6g\",\"-1\"],\"Vitamin A\":\"0%\",\"Vitamin C\":\"0%\",\"Calcium\":\"7%\",\"Iron\":\"16%\",\"ingredients\":\"Beef & Lamb Gyros, Pita Bread\"}}]},\"Bruin Plate\":{\"Freshly Bowled\":[{\"name\":\"Egg White\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/061005/1\",\"itemcodes\":{\"V\":\"Vegetarian_Menu_Option\",\"AEGG\":\"Contains_Eggs\"},\"nutrition\":{\"serving_size\":\"Serving Size 1 each\",\"Calories\":\"40\",\"Fat_Cal.\":\"0\",\"Total_Fat\":[\"0g\",\"0%\"],\"Saturated_Fat\":[\"0g\",\"0%\"],\"Trans_Fat\":[\"0g\",\"-1\"],\"Cholesterol\":[\"0mg\",\"0%\"],\"Sodium\":[\"134.4mg\",\"6%\"],\"Total_Carbohydrate\":[\"0.9g\",\"1%\"],\"Dietary_Fiber\":[\"0g\",\"0%\"],\"Sugars\":[\"-1\",\"-1\"],\"Protein\":[\"8.3g\",\"-1\"],\"Vitamin A\":\"0%\",\"Vitamin C\":\"0%\",\"Calcium\":\"1%\",\"Iron\":\"0%\",\"ingredients\":\"Egg Whites\"}}]}}}\",\"deletedAt\":null,\"menuDate\":\"2018-03-05\",\"createdAt\":\"2018-03-04T08:02:22.066Z\",\"updatedAt\":\"2018-03-04T08:02:22.066Z\"},{\"id\":3,\"overviewMenu\":\"{\"breakfast\":{\"De Neve\":{\"Flex Bar\":[{\"name\":\"Chilaquiles Con Huevo\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/140128/2\",\"itemcodes\":{\"V\":\"Vegetarian_Menu_Option\",\"AMLK\":\"Contains_Dairy\",\"AEGG\":\"Contains_Eggs\",\"AWHT\":\"Contains_Wheat\"},\"nutrition\":{\"serving_size\":\"Serving Size 2 oz\",\"Calories\":\"116\",\"Fat_Cal.\":\"60\",\"Total_Fat\":[\"6.7g\",\"10%\"],\"Saturated_Fat\":[\"1.8g\",\"9%\"],\"Trans_Fat\":[\"0.1g\",\"-1\"],\"Cholesterol\":[\"32.8mg\",\"11%\"],\"Sodium\":[\"150.2mg\",\"6%\"],\"Total_Carbohydrate\":[\"10.4g\",\"8%\"],\"Dietary_Fiber\":[\"2.1g\",\"8%\"],\"Sugars\":[\"0.3g\",\"-1\"],\"Protein\":[\"4.3g\",\"-1\"],\"Vitamin A\":\"9%\",\"Vitamin C\":\"1%\",\"Calcium\":\"6%\",\"Iron\":\"11%\",\"ingredients\":\"Enchilada Sauce (Water, Flour, Dry Guajillo Chili Pepper, Olive Oil Blend, Garlic, Sea Salt), Tortilla Chips (White Corn Tortilla, Oil), Refried Beans (Water, Pinto Beans, Olive Oil Blend, Onion, Garlic, Jalapeño Peppers, Sea Salt, Pepper), Eggs, Jack Cheese, Olive Oil Blend\"}}]},\"Bruin Plate\":{\"Freshly Bowled\":[{\"name\":\"Egg White\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/061005/1\",\"itemcodes\":{\"V\":\"Vegetarian_Menu_Option\",\"AEGG\":\"Contains_Eggs\"},\"nutrition\":{\"serving_size\":\"Serving Size 1 each\",\"Calories\":\"40\",\"Fat_Cal.\":\"0\",\"Total_Fat\":[\"0g\",\"0%\"],\"Saturated_Fat\":[\"0g\",\"0%\"],\"Trans_Fat\":[\"0g\",\"-1\"],\"Cholesterol\":[\"0mg\",\"0%\"],\"Sodium\":[\"134.4mg\",\"6%\"],\"Total_Carbohydrate\":[\"0.9g\",\"1%\"],\"Dietary_Fiber\":[\"0g\",\"0%\"],\"Sugars\":[\"-1\",\"-1\"],\"Protein\":[\"8.3g\",\"-1\"],\"Vitamin A\":\"0%\",\"Vitamin C\":\"0%\",\"Calcium\":\"1%\",\"Iron\":\"0%\",\"ingredients\":\"Egg Whites\"}}]}},\"lunch\":{\"Covel\":{\"Exhibition Kitchen\":[{\"name\":\"Build-Your-Own Pasta Bar\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/999070/1\",\"itemcodes\":{},\"nutrition\":{\"serving_size\":\"\",\"ingredients\":\"\"}}],\"Euro Kitchen\":[{\"name\":\"Beef & Lamb Gyro\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/075000/1\",\"itemcodes\":{\"AMLK\":\"Contains_Dairy\",\"AWHT\":\"Contains_Wheat\",\"ASOY\":\"Contains_Soy\"},\"nutrition\":{\"serving_size\":\"Serving Size 1 each\",\"Calories\":\"473\",\"Fat_Cal.\":\"263\",\"Total_Fat\":[\"29.2g\",\"45%\"],\"Saturated_Fat\":[\"11.5g\",\"58%\"],\"Trans_Fat\":[\"0g\",\"-1\"],\"Cholesterol\":[\"57.3mg\",\"19%\"],\"Sodium\":[\"977.4mg\",\"41%\"],\"Total_Carbohydrate\":[\"32.9g\",\"25%\"],\"Dietary_Fiber\":[\"1g\",\"4%\"],\"Sugars\":[\"1.6g\",\"-1\"],\"Protein\":[\"17.6g\",\"-1\"],\"Vitamin A\":\"0%\",\"Vitamin C\":\"0%\",\"Calcium\":\"7%\",\"Iron\":\"16%\",\"ingredients\":\"Beef & Lamb Gyros, Pita Bread\"}}]},\"Bruin Plate\":{\"Freshly Bowled\":[{\"name\":\"Egg White\",\"recipelink\":\"http://menu.dining.ucla.edu/Recipes/061005/1\",\"itemcodes\":{\"V\":\"Vegetarian_Menu_Option\",\"AEGG\":\"Contains_Eggs\"},\"nutrition\":{\"serving_size\":\"Serving Size 1 each\",\"Calories\":\"40\",\"Fat_Cal.\":\"0\",\"Total_Fat\":[\"0g\",\"0%\"],\"Saturated_Fat\":[\"0g\",\"0%\"],\"Trans_Fat\":[\"0g\",\"-1\"],\"Cholesterol\":[\"0mg\",\"0%\"],\"Sodium\":[\"134.4mg\",\"6%\"],\"Total_Carbohydrate\":[\"0.9g\",\"1%\"],\"Dietary_Fiber\":[\"0g\",\"0%\"],\"Sugars\":[\"-1\",\"-1\"],\"Protein\":[\"8.3g\",\"-1\"],\"Vitamin A\":\"0%\",\"Vitamin C\":\"0%\",\"Calcium\":\"1%\",\"Iron\":\"0%\",\"ingredients\":\"Egg Whites\"}}]}}}\",\"deletedAt\":null,\"menuDate\":\"2018-03-06\",\"createdAt\":\"2018-03-04T08:02:22.066Z\",\"updatedAt\":\"2018-03-04T08:02:22.066Z\"}]}".utf8Encoded
        case .getHours:
            return "".utf8Encoded //TODO Sample Data if I need it
        case .createUser:
            return Data()
        case .loginUser:
            return Data()
        case .readUser:
            return Data()
        case .updateUser:
            return Data()
        case .deleteUser:
            return Data()
        case .matchUser:
            return Data()
        }
    }
    var headers: [String: String]? {
        switch self {
        case .getCurrentActivityLevels, .getDetailedMenu, .getOverviewMenu, .getHours:
            return ["Content-type": "application/json"]
        case .createUser:
            return ["Content-Type": "application/json"]
        case .loginUser:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        case .readUser, .updateUser, .deleteUser, .matchUser:
            var temp = "Bearer "
            temp += UserManager.shared.getAccessToken()
            return ["Authorization": temp]
        }
    }
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}










