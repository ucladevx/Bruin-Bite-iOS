//
//  File.swift
//  Bruin Bite
//
//  Created by Hirday Gupta on 9/28/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

extension Date {
    
    private struct Formatters {
        static let yearMonthDayFormatter = { () -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    }
    
    /**
     Optionally initialises a date object from a string with format "yyyy-MM-dd" (e.g. 2018-09-28). Returns nil if failed.
     
     - Parameters:
        - fromYearMonthDayString: A string with format "yyyy-MM-dd"
     */
    init? (fromYearMonthDayString ymdString: String) {
        guard let date = Formatters.yearMonthDayFormatter.date(from: ymdString) else {
            return nil
        }
        self.init(timeIntervalSince1970: date.timeIntervalSince1970)
    }
    
    func isWeekend() -> Bool {
        let currentWeekday = Calendar.current.component(.weekday, from: self)
        // 7 - saturday, 1 - sunday
        return (currentWeekday == 7 || currentWeekday == 1)
    }
}
