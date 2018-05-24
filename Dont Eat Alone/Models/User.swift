//
//  User.swift
//  Dont Eat Alone
//
//  Created by Samuel J. Lee on 5/20/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

//USER MODEL

struct UserLog {
    let access_token: String
    let refresh_token: String
}

extension UserLog: Decodable {
    enum UserCodingKeys: String, CodingKey {
        case access_token
        case refresh_token
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        
        access_token = try container.decode(String.self, forKey: .access_token)
        refresh_token = try container.decode(String.self, forKey: .refresh_token)
    }
}

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
