//
//  LogManager.swift
//  Bruin Bite
//
//  Created by Kameron Carr on 9/1/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

enum LogLevel {
    /** Message describing an error that causes catastrophic failure. */
    case error
    /** Message describing an error that causes a minor inconvenience. */
    case warning
    /** Message describing some general information. */
    case info
    /** Messages used solely for debug purposes. All DEBUG logs will be removed before pushing to production. */
    case debug
    /** Lengthy messages used for detailed descriptions. */
    case verbose
    /** Messages that don't fall under any of these categories (be very sure of this) */
    case other
    /** Messages that don't want headers before their log outputs. */
    case none
    
    func getHeader() -> String {
        switch self {
        case .error:
            return "❤️ -ERROR- ❤️"
        case .warning:
            return "💛 -WARNING- 💛"
        case .info:
            return "💚 -INFO- 💚"
        case .debug:
            return "💙 -DEBUG- 💙"
        case .verbose:
            return "💜 -VERBOSE- 💜"
        case .other:
            return "🖤 -OTHER- 🖤"
        default:
            return ""
        }
    }
}

class Logger {
    
    init() {    }
    
    /**
     Prints the given message to the log pre-fixed by the header associated with the given log level.
     
     - Parameters:
     - message: A string with the message that needs to be logged.
     - level: The LogLevel with which the message needs to be logged
     */
    static func log(_ message:String, withLevel level:LogLevel) {
        
        if(message.isEmpty)
        {
            log("Tried to log empty error of level \(level)", withLevel: .warning)
            return
        }
        
        let header = level.getHeader()
        
        print("\(header) \(message)\n")
    }
}
