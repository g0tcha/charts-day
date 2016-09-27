//
//  FeedingTableViewCell.swift
//  FeedingHistoryLab
//
//  Created by vincent on 19/09/2016.
//  Copyright © 2016 infostrates. All rights reserved.
//

import UIKit

class FeedingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
