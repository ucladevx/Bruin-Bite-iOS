//
//  ErrorLogger.swift
//  Bruin Bite
//
//  Created by Kameron Carr on 9/1/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

enum ErrorType: String {
    case error = "❤️ -ERROR- ❤️"
    case warning = "💛 -WARNING- 💛"
    case info = "💚 -INFO- 💚"
    case debug = "💙 -DEBUG- 💙"
    case verbose = "💜 -VERBOSE- 💜"
    case other = "🖤 -OTHER- 🖤"
    case none = ""
}

class Logger {
    static let shared = Logger()
    
    private init() {    }
    
    func handle(type:ErrorType, message:String) {
        
        if(message == "")
        {
            handle(type: .warning, message: "Tried to log empty error of type \(type)")
            return
        }
        
        let header:String = type.rawValue
        print("\(header) \(message)\n")
    }
}
