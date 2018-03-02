//
//  ActivityLevels.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 3/1/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

//struct ActivityLevelData{
//    let activityLevels: [Location: Int]
//}
//
//struct ActivityLevels: Codable{
//    let level: [[String:[Location: String]]]
//}


struct ActivityLevel{
    var isAvailable: Bool = false
    var data: [Location: Int] = [:]
}

