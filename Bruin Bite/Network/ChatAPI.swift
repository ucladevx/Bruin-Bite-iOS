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
}

struct Last50MessagesResult: Decodable {
    var tester: String
    var messages: [ChatMessage]
}

class ChatAPI {
    
    var delegate: ChatMessagesDelegate?
    
    private let BACKEND_GET_LAST_50_MSGS_URL = "https://api.bruin-bite.com/api/v1/messaging/messages/"
    
    public func getLast50Messages(forChatRoomWithLabel chatRoomLabel: String?) {
        //  Load the last 50 messages from the server when the view controller loads
        if let chatRoomLabel = chatRoomLabel {
            Alamofire.request(BACKEND_GET_LAST_50_MSGS_URL + chatRoomLabel + "/").responseJSON { response in
                if let result = response.data {
                    if let resultStruct = try? JSONDecoder().decode(Last50MessagesResult.self, from: result) {
                        self.delegate?.didReceiveMessages(messages: resultStruct.messages)
                    } else {
                        print ("Error getting last 50 messages!")
                    }
                }
            }
        } else {
            print ("No chat room label given")
        }
    }
}
