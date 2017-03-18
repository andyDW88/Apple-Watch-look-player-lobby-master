//
//  CustomCollectionViewCell.swift
//  gameUI
//
//  Created by MrD on 1/29/16.
//  Copyright © 2016 MrD. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    var randomNum = String(arc4random()%10)
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var connect: UIButton!
    @IBOutlet var roomNumCount: UILabel!
    @IBOutlet var edgeColor: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 64
        imageView.clipsToBounds = true
        edgeColor.layer.cornerRadius = 70
        edgeColor.clipsToBounds = true
        edgeColor.backgroundColor = Color.randomColor
        
        roomNumCount.layer.backgroundColor = UIColor.blackColor().CGColor
        roomNumCount.layer.cornerRadius = 17.1
        roomNumCount.clipsToBounds = true
        roomNumCount.text = randomNum
        
        
        
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSizeMake(0, 2)
        layer.shadowRadius  = 2
        layer.shadowOpacity = 0.8
    }
    
    enum Color {
        case ColorOne
        case ColorTwo
        case ColorThree
        case ColorFour
        
        private var color: UIColor {
            switch self {
            case .ColorOne: return UIColor.redColor()
            case .ColorTwo: return UIColor.blueColor()
            case .ColorThree: return UIColor.purpleColor()
            case .ColorFour: return UIColor.brownColor()    
            }
        }
        
        static var all: [Color] = [.ColorOne, .ColorTwo, .ColorThree, .ColorFour]
        
        static var randomColor: UIColor {
            let randomIndex = Int(arc4random_uniform(UInt32(all.count)))
            return all[randomIndex].color
        }
    }

}
