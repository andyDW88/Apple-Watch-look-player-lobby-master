//
//  choicesTableViewCell.swift
//  gameUI
//
//  Created by MrD on 3/1/16.
//  Copyright © 2016 MrD. All rights reserved.
//

import UIKit

class choicesTableViewCell: UITableViewCell {

    
    @IBOutlet var sequenceLbl: UILabel!
    @IBOutlet var showChoices: UILabel!
    @IBOutlet var actionBtn: UIButton!
    @IBAction func refresh() {
        self.actionBtn.rotate360Degrees()
        // Perhaps start a process which will refresh the UI...
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: CAAnimationDelegate? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 6.0
        rotateAnimation.toValue = CGFloat(M_PI * 1.0)
        rotateAnimation.duration = duration
        
        if let delegate = completionDelegate {
            rotateAnimation.delegate = delegate
        }
        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
}
