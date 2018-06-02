//
//  ChatAPI.swift
//  Dont Eat Alone
//
//  Created by Hirday Gupta on 28/05/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import Alamofire

protocol ChatMessagesDelegate {
    func didReceiveMessages(messages: [ChatMessage])
    func didReceiveLabel(label: String)
}

struct Last50MessagesResult: Decodable {
    var tester: String
    var messages: [ChatMessage]
}

struct LabelResult: Decodable {
    var label: String
}

class ChatAPI {
    
    var delegate: ChatMessagesDelegate?
    
    //var chatRoomLabel: String
    
    public func getChatLabel(user1: String, user2: String) {
        let param = ["user1": user1, "user2": user2]
        Alamofire.request("https://api.bruin-bite.com/api/v1/messages/new/", method: HTTPMethod.get, parameters: param, headers: nil).responseJSON { response in
            if let result = response.data {
                if let resultStruct = try? JSONDecoder().decode(LabelResult.self, from: result) {
                    self.delegate?.didReceiveLabel(label: resultStruct.label)
                } else {
                    print ("Error acquiring label!")
                }
            }
        }
    }
    
    public func getLast50Messages(forChatRoomWithLabel chatRoomLabel: String) {
        //  Load the last 50 messages from the server when the view controller loads
        Alamofire.request("https://api.bruin-bite.com/api/v1/messages/" + chatRoomLabel + "/").responseJSON { response in
            if let result = response.data {
                if let resultStruct = try? JSONDecoder().decode(Last50MessagesResult.self, from: result) {
                    self.delegate?.didReceiveMessages(messages: resultStruct.messages)
                } else {
                    print ("Error getting last 50 messages!")
                }
            }
        }
    }
}
