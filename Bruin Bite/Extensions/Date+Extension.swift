//
//  Date+Extension.swift
//  Bruin Bite
//
//  Created by Kameron Carr on 2/18/19.
//  Copyright © 2019 Dont Eat Alone. All rights reserved.
//

import Foundation
extension Date {
    private struct Formatters {
        static let userFriendlyMonthDayYearFormatter: DateFormatter = { () -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yyyy"
            return formatter
        }()
        
        static let yearMonthDayFormatter: DateFormatter = { () -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
        
        static let monthDayYearFormatter: DateFormatter = { () -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
            return formatter
        }()
        
        static let RCF3339Formatter: DateFormatter = { () -> DateFormatter in
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return formatter
        }()
    }
    
    init? (fromUserFriendlyMonthDayYearString userFriendlyMonthDayYearString: String ) {
        guard let date = Formatters.userFriendlyMonthDayYearFormatter.date(from: userFriendlyMonthDayYearString) else {
            return nil
        }
        let startOfDate = Calendar.current.startOfDay(for: date)
        self.init(timeIntervalSince1970: startOfDate.timeIntervalSince1970)
    }
    
    init? (fromMonthDayYearString monthDayYearString: String) {
        guard let date = Formatters.monthDayYearFormatter.date(from: monthDayYearString) else {
            return nil
        }
        let startOfDate = Calendar.current.startOfDay(for: date)
        self.init(timeIntervalSince1970: startOfDate.timeIntervalSince1970)
    }
    
    init? (fromRCF3339String rcf3339String: String, usingStartOfDay: Bool = false) {
        guard let date = Formatters.RCF3339Formatter.date(from: rcf3339String) else {
            return nil
        }
        if usingStartOfDay {
            let startOfDate = Calendar.current.startOfDay(for: date)
            self.init(timeIntervalSince1970: startOfDate.timeIntervalSince1970)
        } else {
            self.init(timeIntervalSince1970: date.timeIntervalSince1970)
        }
    }
    
    func yearMonthDayString() -> String {
        return Formatters.yearMonthDayFormatter.string(from: self)
    }
}

