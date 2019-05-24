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
    case createUser(email: String, password: String, firstName: String, is_active: Bool)
    case readUser(email: String)
    case loginUser(username:String, password: String, grant_type: String, client_id: String, client_secret: String)
    case logoutUser(token: String, client_id: String, client_secret: String)
    case updateUser(email: String, password: String, first_name: String, last_name: String, major: String, minor: String, year: Int, self_bio: String) //send it as it is if it hasn't changed
    case updateDeviceID
    case deleteUser(email: String)
    case matchUser(user: Int, meal_times: [String], meal_day: String, meal_period: String, dining_halls: [String])
    case refreshToken(grant_type: String, client_id: String, client_secret: String, refresh_token: String)
    case getRequests(user: Int, status: [String])
    case getMatches(user: Int)
//    case requestMatch(user: Int, meal_times: [String], meal_day: String, meal_period: [String], dining_halls: [String])
    case chatList(forUserWithID: Int)
    case last50Messages(forChatRoomLabel: String)
    case unmatchUser(chatURL: String)
    case reportUser(user: Int, chatURL: String, reportDetails: String)
    case uploadProfilePicture(image: Data)
    case getProfilePicture(forUserWithID: Int)
}

extension MainAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .getCurrentActivityLevels, .getOverviewMenu, .getDetailedMenu, .getHours:
            return URL(string: "https://api.bruin-bite.com/api/v1")!
        case .createUser, .readUser, .loginUser, .logoutUser, .updateUser, .deleteUser, .matchUser, .refreshToken, .getRequests, .getMatches, .chatList, .last50Messages, .unmatchUser, .reportUser, .uploadProfilePicture, .getProfilePicture:
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
        case .loginUser, .refreshToken:
            return "/users/o/token/"
        case .logoutUser:
            return "/users/o/revoke_token"
        case .readUser, .updateUser, .deleteUser, .updateDeviceID:
            return "/users/data/"
        case .matchUser:
            return "/users/matching/requests"
        case .getRequests:
            return "/users/matching/requests"
        case .getMatches:
            return "/users/matching/matches"
        case .chatList:
            return "users/matching/chats"
        case .last50Messages(let chatRoomLbl):
            return "/messaging/messages/\(chatRoomLbl)/"
        case .reportUser:
            return "/users/matching/report"
        case .unmatchUser:
            return "users/matching/matches"
        case .uploadProfilePicture:
            return "/users/profile_picture/"
        case .getProfilePicture:
            return "/users/profile_picture/"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getCurrentActivityLevels, .getOverviewMenu, .getDetailedMenu, .getHours, .readUser, .getRequests, .getMatches, .chatList, .last50Messages, .getProfilePicture:
            return .get
        case .createUser, .loginUser, .logoutUser, .matchUser, .refreshToken, .reportUser, .uploadProfilePicture:
            return .post
        case .updateUser, .updateDeviceID:
            return .put
        case .deleteUser, .unmatchUser:
            return .delete
        }
    }
    var task: Task{
        switch self {
        case .getCurrentActivityLevels, .getOverviewMenu, .getDetailedMenu, .getHours:
            return .requestPlain
        case .createUser(let email, let password, let first_name, let is_active):
            return .requestParameters(parameters: ["email": email, "password": password, "first_name": first_name, "is_active": is_active, "device_id": UserDefaults.standard.string(forKey: "Dev_Token") ?? ""], encoding: JSONEncoding.default)
        case .loginUser(let username, let password, let grant_type, let client_id, let client_secret):
            return .requestParameters(parameters: ["username": username, "password": password, "grant_type": grant_type, "client_id": client_id, "client_secret": client_secret], encoding: URLEncoding.default)
        case .logoutUser(let token, let client_id, let client_secret):
            return .requestParameters(parameters: ["token": token, "client_id": client_id, "client_secret": client_secret], encoding: URLEncoding.default)
        case .readUser(let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.queryString)
        case .updateUser(let email, let password, let first_name, let last_name, let major, let minor, let year, let self_bio):
            return .requestParameters(parameters: ["email": email, "password": password, "first_name": first_name, "last_name": last_name, "major": major, "minor": minor, "year": year, "self_bio": self_bio], encoding: JSONEncoding.default)
        case .updateDeviceID:
            let params = ["email": UserManager.shared.getEmail(), "device_id": UserDefaults.standard.string(forKey: "Dev_Token") ?? ""]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .deleteUser(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        case .matchUser(let user, let meal_times, let meal_day, let meal_period, let dining_halls):
            return .requestParameters(parameters: ["user": user, "meal_times": meal_times, "meal_day": meal_day, "meal_period": meal_period, "dining_halls": dining_halls], encoding: JSONEncoding.default)
        case .refreshToken(let grant_type, let client_id, let client_secret, let refresh_token):
            return .requestParameters(parameters: ["grant_type": grant_type, "client_id": client_id, "client_secret": client_secret, "refresh_token": refresh_token], encoding: URLEncoding.default)
        case .getRequests(let user, let status):
            return .requestParameters(parameters: ["user_id": user, "status": status[0]], encoding: URLEncoding.default)
        case .getMatches(let user):
            return .requestParameters(parameters: ["id": user], encoding: URLEncoding.default)
        case .chatList(let userId):
            return .requestParameters(parameters: ["id": userId], encoding: URLEncoding.default)
        case .last50Messages:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default) // empty because url handled param
        case .reportUser(let user, let chatURL, let reportDetails):
            return .requestParameters(parameters: ["reporting_user": user, "chat_room_url": chatURL, "report_details": reportDetails], encoding: JSONEncoding.default)
        case .unmatchUser(let chatURL):
            return .requestParameters(parameters: ["chat_url": chatURL], encoding: URLEncoding.default)
        case .uploadProfilePicture(let profilePicture):
            let pictureData = MultipartFormData(provider: .data(profilePicture), name: "profile_picture", fileName: "profile.jpeg", mimeType: "multipart/form-data")
            let multipartData = [pictureData]
            return .uploadMultipart(multipartData)
        case .getProfilePicture(let userID):
            return .requestParameters(parameters: ["user_id": userID], encoding: URLEncoding.default)
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
        case .refreshToken:
            return Data()
        case .getRequests:
            return Data();
        case .getMatches:
            return Data();
        case .chatList:
            return Data()
        case .last50Messages:
            return Data()
        case .reportUser:
            return Data()
        case .unmatchUser:
            return Data()
        case .uploadProfilePicture:
            return Data()
        case .getProfilePicture:
            return Data()
        case .logoutUser:
            return Data()
        case .updateDeviceID:
            return Data()
        }
    }
    var headers: [String: String]? {
        switch self {
        case .getCurrentActivityLevels, .getDetailedMenu, .getOverviewMenu, .getHours:
            return ["Content-type": "application/json"]
        case .createUser:
            return ["Content-Type": "application/json"]
        case .loginUser, .refreshToken, .logoutUser:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        case .readUser, .updateUser, .updateDeviceID, .deleteUser, .matchUser, .getRequests, .getMatches, .chatList, .last50Messages, .reportUser, .unmatchUser, .uploadProfilePicture, .getProfilePicture:
            var temp = "Bearer "
            temp += UserDefaultsManager.shared.getAccessToken()
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
