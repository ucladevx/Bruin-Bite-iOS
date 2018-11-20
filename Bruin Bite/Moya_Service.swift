//
//  Moya_Service.swift
//  Don't Eat Alone
//
//  Created by Ashwin Vivek on 1/27/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import Moya

enum API_methods {
    case getAllMenus
}

extension API_methods: TargetType {
    var baseURL: URL { return URL(string: "http://bruindining.herokuapp.com")! }
    var path: String {
        switch self {
        case .getAllMenus:
            return "/overview"
//        case .showUser(let id), .updateUser(let id, _, _):
//            return "/users/\(id)"
//        case .createUser(_, _):
//            return "/users"
//        case .showAccounts:
//            return "/accounts"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getAllMenus:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getAllMenus: // Send no parameters
            return .requestPlain
        }
    }
    var sampleData: Data {
        switch self {
        case .getAllMenus:
            return "{\"date\":, \"first_name\": \"Harry\", \"last_name\": \"Potter\"}".utf8Encoded
    
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
