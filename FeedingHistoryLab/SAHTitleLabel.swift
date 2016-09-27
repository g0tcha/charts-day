//
//  SAHTitleLabel.swift
//  FeedingHistoryLab
//
//  Created by vincent on 16/09/2016.
//  Copyright © 2016 infostrates. All rights reserved.
//

import UIKit

class SAHTitleLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var height: CGFloat = 0
        var leading: CGFloat = 0
        
        for constraint in constraints {
            if constraint.firstAttribute == .height {
                height = constraint.constant
            }
            
            if constraint.firstAttribute == .leading {
                leading = constraint.constant
            }
        }
        
        let border = CALayer()
        border.frame = CGRect(x: frame.origin.x, y: height - 1, width: frame.size.width, height: 1)
        border.backgroundColor = UIColor.white.cgColor
        
        layer.addSublayer(border)
    }

}
