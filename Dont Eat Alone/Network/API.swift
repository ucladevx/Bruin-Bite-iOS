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
