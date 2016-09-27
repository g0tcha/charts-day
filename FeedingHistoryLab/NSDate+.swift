//
//  NSDate+.swift
//  FeedingHistoryLab
//
//  Created by vincent on 21/09/2016.
//  Copyright © 2016 infostrates. All rights reserved.
//

import Foundation

extension Date {
    func getSixHoursSlices() -> [String]? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        
        if let future6 = NSCalendar.current.date(byAdding: .hour, value: 6, to: self), let future12 = NSCalendar.current.date(byAdding: .hour, value: 12, to: self) {
            
            let past6 = dateFormatter.string(from: Date().addingTimeInterval(-3600 * 6))
            let past12 = dateFormatter.string(from: Date().addingTimeInterval(-3600 * 12))
            
            return [dateFormatter.string(from: future12), dateFormatter.string(from: future6), dateFormatter.string(from: self), past6, past12]
        }
        
        return nil
    }
    
    func getToday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM, d"
        
        return dateFormatter.string(from: self)
    }
    
    static func getHour(value: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
    
}

extension TimeInterval {
    // Return timestamp string like "Tuesday, Sep, 27"
    func getDayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM, d"
        
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}
