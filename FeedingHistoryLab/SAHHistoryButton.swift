//
//  SAHHistoryButton.swift
//  FeedingHistoryLab
//
//  Created by vincent on 19/09/2016.
//  Copyright © 2016 infostrates. All rights reserved.
//

import UIKit

class SAHHistoryButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 8
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
    }

}
