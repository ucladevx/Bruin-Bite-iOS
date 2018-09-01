//
//  ChatListAPI.swift
//  Bruin Bite
//
//  Created by Hirday Gupta on 02/06/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import Alamofire

struct ChatListItem: Codable {
    var id: Int
    var user1: Int
    var user1_first_name: String
    var user1_last_name: String
    var user2_first_name: String
    var user2_last_name: String
    var user2: Int
    var meal_datetime: String
    var meal_period: String
    var dining_hall: String
    var chat_url: String // actually, chat room label
}

struct ChatListResult: Codable {
    var chatListItems: [ChatListItem]
}

protocol ChatListDelegate {
    func didReceiveChatList(chatListData: [ChatListItem])
}

class ChatListAPI {
    
    var delegate: ChatListDelegate? = nil
    let CHAT_LIST_BACKEND_URL = "https://api.bruin-bite.com/api/v1/users/matching/new/"
    
    func getChatList(forUserWithID user: Int) {
        let param = ["id": user]
        Alamofire.request(CHAT_LIST_BACKEND_URL, method: HTTPMethod.get, parameters: param, headers: nil).responseJSON { response in
            
            if let result = response.data {
                if let resultStruct = try? JSONDecoder().decode([ChatListItem].self, from: result) {
                    self.delegate?.didReceiveChatList(chatListData: resultStruct)
                } else {
                    Logger.shared.handle(type: .error, message: "Could not parse response JSON into ChatListResult struct")
                }
            } else {
                Logger.shared.handle(type: .error, message: "Could not acquire chat list!")
            }
        }
    }
    
}
