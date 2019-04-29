//
//  ChatAPI.swift
//  Dont Eat Alone
//
//  Created by Hirday Gupta on 28/05/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import Alamofire
import Moya

protocol ChatMessagesDelegate {
    func didReceiveMessages(messages: [ChatMessage])
}

struct Last50MessagesResult: Decodable {
    var tester: String
    var messages: [ChatMessage]
}

class ChatAPI {
    
    var delegate: ChatMessagesDelegate?
    private let provider = MoyaProvider<MainAPI>()
    
    public func getLast50Messages(forChatRoomWithLabel chatRoomLabel: String?) {
        //  Load the last 50 messages from the server when the view controller loads
        guard let chatRoomLabel = chatRoomLabel else {
            print ("No chat room label given")
            return
        }

        provider.request(.last50Messages(forChatRoomLabel: chatRoomLabel)) { result in
            switch result {
            case let .success(response):
                do {
                    let resultStruct = try JSONDecoder().decode(Last50MessagesResult.self, from: response.data)
                    self.delegate?.didReceiveMessages(messages: resultStruct.messages)
                } catch let err {
                    print ("Error getting last 50 messages!")
                    print (err)
                }
            case let .failure(error):
                print (error.errorDescription ?? "Moya request failure: last 50 msgs")
            }
        }
    }
}
