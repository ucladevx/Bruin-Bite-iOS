//
//  ChatListAPI.swift
//  Bruin Bite
//
//  Created by Hirday Gupta on 02/06/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import Alamofire
import Moya

struct ChatListItem: Codable {
    var id: Int
    var user1: Int
    var user1_first_name: String
    var user1_last_name: String
    var user2_first_name: String
    var user2_last_name: String
    var user2: Int
    var meal_datetime: String // yyyy-MM-dd HH:mm:ss
    var meal_period: String // BR, LU, DI
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
    private let provider = MoyaProvider<MainAPI>()
    
    func getChatList(forUserWithID user: Int) {
        provider.request(.chatList(forUserWithID: user)) { result in
            switch result {
                case let .success(response):
                    do {
                        let resultStruct = try JSONDecoder().decode([ChatListItem].self, from: response.data)
                        self.delegate?.didReceiveChatList(chatListData: resultStruct)
                    } catch let err {
                        print ("Error parsing response JSON into ChatListResult struct")
                        print (err)
                    }
                case let .failure(error):
                    print ("Error acquiring chat list!")
                    print (error.errorDescription ?? "")
            }
        }
    }
}

//
//        let param = ["id": user]
//        Alamofire.request(CHAT_LIST_BACKEND_URL, method: HTTPMethod.get, parameters: param, headers: nil).responseJSON { response in
//
//            if let result = response.data {
//                if let resultStruct = try? JSONDecoder().decode([ChatListItem].self, from: result) {
//                    self.delegate?.didReceiveChatList(chatListData: resultStruct)
//                } else {
//                    print ("Error parsing response JSON into ChatListResult struct")
//                }
//            } else {
//                print ("Error acquiring chat list!")
//            }
//        }
//        /* Test chat list item:
//        self.delegate?.didReceiveChatList(chatListData: [
//            ChatListItem(id: 4,
//                    user1: -1,
//                    user1_first_name: "Joe",
//                    user1_last_name: "Bruin",
//                    user2_first_name: "Josie",
//                    user2_last_name: "Bruin",
//                    user2: 2,
//                    meal_datetime: "2019-02-10T04:47:03+0000",
//                    meal_period: "LU",
//                    dining_hall: "De Neve",
//                    chat_url: "hmmm"
//            )
//        ])*/
//    }
//
//}
