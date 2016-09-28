//
//  DateValueFormatter.swift
//  FeedingHistoryLab
//
//  Created by vincent on 26/09/2016.
//  Copyright © 2016 infostrates. All rights reserved.
//

import Foundation
import Charts

// MARK: - DateValueFormatter
// -- Return x axis value formatted like "6 PM"s
class DateValueFormatter: NSObject {
    var times: [TimeInterval]!
    
    override init() {
        super.init()
    }
    
    init(times: [TimeInterval]) {
        super.init()
        
        self.times = times
    }
}

// MARK: - IAxisValueFormatter
extension DateValueFormatter: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard value >= 0 && value < 144 else {
            return ""
        }
        
        let timestamp: TimeInterval = (times[Int(value)])
        let hours = timestamp.getHour()
        
        
        if hours % 6 == 0 {
            return timestamp.getHourWithPeriod()
        }
        
        return ""
    }
}
