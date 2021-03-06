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

        static let matchRequestMealTimeFormatter: DateFormatter = { () -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
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

        static let hourMinuteFormatter: DateFormatter = { () -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm"
            return formatter
        }()
        
        static let hourMinuteAmPmFormatter: DateFormatter = { () -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            return formatter
        }()

        static let PendingRequestsFormatter: DateFormatter = { () -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd, yyyy"
            return formatter
        }()
    }

    init? (fromStartOfDate: Bool) {
        if fromStartOfDate {
            let startOfDate = Calendar.current.startOfDay(for: Date())
            self.init(timeIntervalSince1970: startOfDate.timeIntervalSince1970)
        } else {
            self.init()
        }
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

    init? (fromYearMonthDayString yearMonthDayString: String) {
        guard let date = Formatters.yearMonthDayFormatter.date(from: yearMonthDayString) else {
            return nil
        }
        let startOfDate = Calendar.current.startOfDay(for: date)
        self.init(timeIntervalSince1970: startOfDate.timeIntervalSince1970)
    }

    init? (fromMatchRequestMealTimeString matchRequestMealTimeString: String) {
        guard let date = Formatters.matchRequestMealTimeFormatter.date(from: matchRequestMealTimeString) else {
            return nil
        }
        self.init(timeIntervalSince1970: date.timeIntervalSince1970)
    }

    func yearMonthDayString() -> String {
        return Formatters.yearMonthDayFormatter.string(from: self)
    }

    func userFriendlyMonthDayYearString() -> String {
        return Formatters.userFriendlyMonthDayYearFormatter.string(from: self)
    }

    func hourMinuteString(withAmPm: Bool = false) -> String {
        if withAmPm {
            return Formatters.hourMinuteAmPmFormatter.string(from: self)
        }
        return Formatters.hourMinuteFormatter.string(from: self)
    }

    func matchRequestMealTimeString() -> String {
        return Formatters.matchRequestMealTimeFormatter.string(from: self)
    }

    func rcf3339String() -> String {
        return Formatters.RCF3339Formatter.string(from: self)
    }

    static func breakfastStartTime(onDate date: Date) -> Date {
        let d = Calendar.current.date(bySetting: .hour, value: 7, of: date) ?? date
        return Calendar.current.date(bySetting: .minute, value: 0, of: d) ?? date
    }

    static func lunchStartTime(onDate date: Date) -> Date {
        let d = Calendar.current.date(bySetting: .hour, value: 11, of: date) ?? date
        return Calendar.current.date(bySetting: .minute, value: 0, of: d) ?? date
    }

    func pendingRequestsString() -> String {
        return Formatters.PendingRequestsFormatter.string(from: self)
    }

    static func dinnerStartTime(onDate date: Date) -> Date {
        let d = Calendar.current.date(bySetting: .hour, value: 16, of: date) ?? date
        return Calendar.current.date(bySetting: .minute, value: 0, of: d) ?? date
    }

    static func getPendingRequestTimeRanges(fromMatchDatetimeStrings datetimes: [String]) -> String? {
        guard datetimes.count > 0 else {
            return nil
        }

        var dates: [Date] = []
        for datetime in datetimes {
            guard let date = Date(fromMatchRequestMealTimeString: datetime) else {
                continue
            }
            dates.append(date)
        }
        
        dates.sort()
        let timeStrings = dates.map { $0.hourMinuteString(withAmPm: true) }
        return timeStrings.joined(separator: ", ")

//        var timeRangeStrings: [String] = []
//        var resultIndex = 0
//        timeRangeStrings.append(dates[0].hourMinuteString())
//
//        var tempvar =  ""
//
//        for i in 0 ..< dates.count-1 {
//            let time_diff = dates[i+1].timeIntervalSince(dates[i])
//            if time_diff <= (15.0*60.0) { // if time diff between adjacent times is 15 mins.
//                timeRangeStrings[0]
//            } else {
//                resultIndex += 1
//            }
//        }
//        return []
    }

}
