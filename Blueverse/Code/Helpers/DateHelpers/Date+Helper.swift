//
//  Date+Helper.swift
//  Blueverse
//
//  Created by Vaibhav Parmar on 01/04/23.
//  Copyright © 2023 Nickelfox. All rights reserved.
//

import Foundation
import FLUtilities

enum DateFormat: String {
    // swiftlint: disable identifier_name
    case MMMMyyyy = "MMMM yyyy"
    case yyyyMMdd = "yyyy-MM-dd"
    case d = "d"
    case e = "E"
    case MMM = "MMM"
    case hmma = "h:mm a"
    case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    case dMMMyyyy = "d MMM yyyy"
    case ddMMyyyy = "dd/MM/yyyy"
    case MMyy = "MM/yy"
    case dMMMyyyyhmma = "d MMM yyyy h:mm a"
    case MMMd = "MMM d"
    case MMMdyyyy = "MMM d, yyyy"
    case yyyy = "yyyy"
    case MMMdyyyyhhmma = "MMM d, yyyy hh:mm a"
    case edMMMyyyyHHmmss = "E, d MMM yyyy HH:mm:ss"
    case yyyyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    case HHmmss = "HH:mm:ss"
    
    var string: String {
        return self.rawValue
    }
    
}

struct DateHelper {
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        // if required update timeZone
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    public static func date(fromString string: String,
                            format: DateFormat) -> Date? {
        let formatter = DateHelper.dateFormatter
        formatter.dateFormat = format.string
        return formatter.date(from: string)
    }
    
    public static func date(fromDate date: Date,
                            format: DateFormat) -> String? {
        let formatter = DateHelper.dateFormatter
        formatter.dateFormat = format.string
        return formatter.string(from: date)
    }
    
    public static func getSecondsBetweenDates(from: Date, to: Date) -> Int {
        let component = Calendar.current.dateComponents([.second], from: from, to: to)
        return component.second ?? 0
    }
    
    public static func convert(dateString: String,
                               fromFormat: DateFormat,
                               toFormat: DateFormat) -> String? {
        guard let date = DateHelper.date(fromString: dateString,
                                         format: fromFormat) else {
            return nil
        }
        let convertDate = DateHelper.date(fromDate: date, format: toFormat)
        return convertDate
    }
    
    public static func convert(date: Date, format: DateFormat) -> Date {
        guard let dateString = DateHelper.date(fromDate: date,
                                               format: format) else {
            return Date()
        }
        let convertDate = DateHelper.date(fromString: dateString,
                                          format: format)
        return convertDate ?? Date()
    }
        
    public static func compare(fromDate: String,
                               toDate: String) -> Bool {
        let fromDate = DateHelper.date(fromString: fromDate,
                                       format: .yyyyMMdd) ?? Date()
        let toDate = DateHelper.date(fromString: toDate,
                                     format: .yyyyMMdd) ?? Date()
        return fromDate.isEqualToDate(toDate)
    }
    
    public static func serverToLocalTime(date: String?) -> Date? {
        guard let serverDate = date,
              let stringToDate = self.date(fromString: serverDate,
                                           format: .yyyyMMddHHmmss) else {
            return nil
        }
        return stringToDate.toCurrentTimeZone()
    }
    
    
    static func daylightSavingTimeZone(from timeZoneString: String) -> TimeZone? {
        let newTimeZoneString = timeZoneString.replacingOccurrences(of: "ST", with: "DT")
        let timeZone = TimeZone(abbreviation: newTimeZoneString)
        return DateHelper.isValid(timeZone) ? timeZone : nil
    }
    
    static func isValid(_ timeZone: TimeZone?) -> Bool {
        guard let timeZone = timeZone else { return false }
        return TimeZone.abbreviationDictionary.contains { (abbreviation, _) in
            timeZone.abbreviation() == abbreviation
        }
    }
}

extension Date {
    
    func isEqualMonthYear(_ date: Date) -> Bool {
        let date = Calendar.current.dateComponents([.month, .year], from: date, to: self)
        return (date.month == 0 && date.year == 0)
    }
    
    func isEqualToDate(_ toDate: Date?) -> Bool {
        guard let toDate = toDate else { return false }
        // format both date to same format to get rid of time comparison
        let formattedSelfDate = DateHelper.convert(date: self,
                                                   format: .yyyyMMdd)
        let formattedToDate = DateHelper.convert(date: toDate,
                                                 format: .yyyyMMdd)
        
        return formattedSelfDate.compare(formattedToDate) == .orderedSame
    }
    
    func formattedYear() -> String? {
        return DateHelper.date(fromDate: self, format: .yyyy)
    }
    
    func text(with format: DateFormat) -> String? {
        return DateHelper.date(fromDate: self, format: format)
    }
    
    func fullDateWithTime() -> String? {
        return DateHelper.date(fromDate: self, format: .MMMdyyyyhhmma)
    }
    
    func MMMdyyyy() -> String? {
        return DateHelper.date(fromDate: self, format: .MMMdyyyy)
    }

}

extension Date {
    
    private func convertToTimeZone(initTimeZone: TimeZone, timeZone: TimeZone) -> Date {
         let delta = TimeInterval(timeZone.secondsFromGMT(for: self) - initTimeZone.secondsFromGMT(for: self))
         return addingTimeInterval(delta)
    }
    
    func toUTCTimeZone() -> Date {
        let localTimeZone = TimeZone.current
        let utcTimeZone = TimeZone(abbreviation: "UTC")
        
        let utcTime = self.convertToTimeZone(initTimeZone: localTimeZone, timeZone: utcTimeZone!)
        return utcTime
    }
    
    func toCurrentTimeZone() -> Date {
        let localTimeZone = TimeZone.current
        let utcTimeZone = TimeZone(abbreviation: "UTC")
        
        let localTime = self.convertToTimeZone(initTimeZone: utcTimeZone!, timeZone: localTimeZone)
        return localTime
    }
    
}
