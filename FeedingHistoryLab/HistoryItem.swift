//
//  HistoryItem.swift
//  FeedingHistoryLab
//
//  Created by vincent on 19/09/2016.
//  Copyright © 2016 infostrates. All rights reserved.
//

import Foundation

class HistoryItem {
    var hour = ""
    var type = ""
    var quantity = ""
    
    init(hour: String, type: String, quantity: String) {
        self.hour = hour
        self.type = type
        self.quantity = quantity
    }
}

class HistoryItemStore {
    static func getHistoryItems() -> [HistoryItem] {
        return [
            HistoryItem(hour: "10h01", type: "Consumption", quantity: "20g"),
            HistoryItem(hour: "10h02", type: "Consumption", quantity: "30g"),
            HistoryItem(hour: "10h03", type: "Consumption", quantity: "40g"),
            HistoryItem(hour: "10h04", type: "Consumption", quantity: "50g"),
            HistoryItem(hour: "10h05", type: "Consumption", quantity: "60g"),
            HistoryItem(hour: "10h06", type: "Consumption", quantity: "70g")
        ]
    }
}
