//
//  vendingItemsTableViewCell.swift
//  gameUI
//
//  Created by MrD on 2/28/16.
//  Copyright © 2016 MrD. All rights reserved.
//

import UIKit

class vendingItemsTableViewCell: UITableViewCell {

    @IBOutlet var priceLbl: UIView!
   
    @IBOutlet var itemPriceLbl: UILabel!
    
    @IBOutlet var engAmountLbl: UILabel!
    
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

