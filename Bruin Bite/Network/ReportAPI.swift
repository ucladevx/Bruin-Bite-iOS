//
//  ReportAPI.swift
//  Bruin Bite
//
//  Created by Kameron Carr on 5/4/19.
//  Copyright © 2019 Dont Eat Alone. All rights reserved.
//

import Foundation
import Moya

class ReportAPI{
    private let provider = MoyaProvider<MainAPI>()
    
    func reportUser(chatURL: String, message: String, completion: @escaping (Bool)->Void){
        provider.request(.reportUser(user: UserManager.shared.getUID(), chatURL: chatURL, reportDetails: message)) { (result) in
            switch(result){
            case let .success(response):
                if response.statusCode == 200 {
                    completion(true)
                }
                else {
                    completion(false)
                }
            case let .failure(error):
                print(error.errorDescription ?? "Could not report user")
                completion(false)
            }
        }
    }
    func unmatchUser(chatURL: String, completion: @escaping (Bool)->Void){
        provider.request(.unmatchUser(chatURL: chatURL)) {
            (result) in
            switch(result){
            case let .success(response):
                if response.statusCode == 200 {
                    completion(true)
                }
                else {
                    completion(false)
                }
            case let .failure(error):
                print(error.errorDescription ?? "Could not unmatch with user")
                completion(false)
            }
        }
    }
}
