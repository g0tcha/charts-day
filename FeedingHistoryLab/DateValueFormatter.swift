//
//  DateValueFormatter.swift
//  FeedingHistoryLab
//
//  Created by vincent on 26/09/2016.
//  Copyright © 2016 infostrates. All rights reserved.
//

import Foundation
import Charts

class DateValueFormatter: NSObject, IAxisValueFormatter {
    var dateFormatter: DateFormatter
    var times: [TimeInterval]?
    
    override init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        
        super.init()
    }
    
    convenience init(times: [TimeInterval]) {
        self.init()
        
        self.times = times
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard value > 0 && value < 144 else {
            return ""
        }
        
        if let timestamp = times?[Int(value)] {
            let result = dateFormatter.string(from: Date(timeIntervalSince1970: timestamp))
            return result
        }
        
        return ""
    }
}
