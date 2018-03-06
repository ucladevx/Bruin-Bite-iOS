//
//  APIService.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 3/1/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import Moya

enum MenuAPI{
    case getCurrentActivityLevels
    case overviewMenu
    case detailedMenu
}

extension MenuAPI: TargetType {
    var baseURL: URL { return URL(string: "http://13.57.209.253:5000/api/v1")!}
    var path: String{
        switch self{
        case .getCurrentActivityLevels:
            return "/menu/ActivityLevels"
        case .overviewMenu:
            return "/menu/OverviewMenu"
        case .detailedMenu:
            return "/menu/DetailedMenu"
        }
        
    }
    var method: Moya.Method {
        switch self {
        case .getCurrentActivityLevels:
            return .get
        }
    }
    var task: Task{
        switch self {
        case .getCurrentActivityLevels:
            return .requestPlain
        }
    }
    //for testing
    var sampleData: Data {
        switch self {
        case .getCurrentActivityLevels:
            return "{\"level\":[{\"id\":748,\"level\":{\"Covel\":\"16%\",\"De Neve\":\"29%\",\"FEAST at Rieber\":\"30%\",\"Bruin Plate\":\"35%\"},\"deletedAt\":null,\"createdAt\":\"2018-03-01T19:32:02.658Z\",\"updatedAt\":\"2018-03-01T19:32:02.658Z\"}]}".utf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
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
