//
//  String+.swift
//  FeedingHistoryLab
//
//  Created by vincent on 28/09/2016.
//  Copyright © 2016 infostrates. All rights reserved.
//

import Foundation

extension String {
    public func indexOfCharacter(char: Character) -> Int? {
        if let idx = characters.index(of: char) {
            return characters.distance(from: startIndex, to: idx)
        }
        return nil
    }
}
