//
//  ChatMessage.swift
//  Dont Eat Alone
//
//  Created by Hirday Gupta on 28/05/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

struct ChatMessage: Codable {
    var timestamp: String
    var handle: String
    var message: String
}
