//
//  User.swift
//  Dont Eat Alone
//
//  Created by Samuel J. Lee on 5/20/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

//USER MODEL FOR LOGIN
//It stores an access tokena nd refresh token
struct UserLog {
    let access_token: String
    let refresh_token: String
}

extension UserLog: Decodable {
    enum UserCodingKeys: String, CodingKey {
        case access_token
        case refresh_token
    }
    //this initializes by decoding the json into the member variables
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        
        access_token = try container.decode(String.self, forKey: .access_token)
        refresh_token = try container.decode(String.self, forKey: .refresh_token)
    }
}
//USER MODEL FOR CREATION
struct UserCreate {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let major: String
    let minor: String
    let year: Int
    let self_bio: String
}


extension UserCreate: Decodable {
    enum UserCodingKeys: String, CodingKey {
        case id
        case email
        case first_name
        case last_name
        case major
        case minor
        case year
        case self_bio
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        email = try container.decode(String.self, forKey: .email)
        first_name = try container.decode(String.self, forKey: .first_name)
        last_name = try container.decode(String.self, forKey: .last_name)
        major = try container.decode(String.self, forKey: .major)
        minor = try container.decode(String.self, forKey: .minor)
        year = try container.decode(Int.self, forKey: .year)
        self_bio = try container.decode(String.self, forKey: .self_bio)
    }
}

//I made a User Struct that holds errors that Terrence returns.
struct UserError {
    let email: [String]?
    let password: [String]?
    let error: String?
    let error_description: String?
    let detail: String?
}

extension UserError: Decodable {
    enum ErrorCodingKeys: String, CodingKey {
        case email
        case password
        case error
        case error_description
        case detail
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: ErrorCodingKeys.self)
        if(container.contains(.email)) {
            self.email = try container.decode([String].self, forKey: .email)
        } else {
            self.email = nil
        }
        if(container.contains(.password)) {
            self.password = try container.decode([String].self, forKey: .password)
        } else {
            self.password = nil
        }
        if(container.contains(.error)) {
            self.error = try container.decode(String.self, forKey: .error)
        } else {
            self.error = nil
        }
        if(container.contains(.error_description)) {
            self.error_description = try container.decode(String.self, forKey: .error_description)
        } else {
            self.error_description = nil
        }
        if(container.contains(.detail)) {
            self.detail = try container.decode(String.self, forKey: .detail)
        } else {
            self.detail = nil
        }
    }
}

//User Model for Match Response

struct MatchRequestData: Codable {
    let user: Int
    let id: Int
    let meal_day: String
    let meal_period: String
    let status: String
    let dining_halls: [String]
    let meal_times: [String]
}










