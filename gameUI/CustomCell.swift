//
//  CustomCell.swift
//  gameUI
//
//  Created by MrD on 2/23/16.
//  Copyright © 2016 MrD. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet var playerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
