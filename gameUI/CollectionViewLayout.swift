//
//  CollectionViewLayout.swift
//  gameUI
//
//  Created by MrD on 2/11/16.
//  Copyright © 2016 MrD. All rights reserved.
//

import UIKit

class CollectionViewLayout: UICollectionViewLayout {

    let COLS = 80
    let ROWS = 80
    
    //space between two icons
    let interimSpace: CGFloat = 1.5
    //each cell has diameter of 80 points
    let itemSize: CGFloat = 150
    
    //computed property representing the center of the animation
    var center: CGPoint {
        return CGPoint(x: (self.cViewSize.width) / 2.0, y: (self.cViewSize.height) / 2.0)
    }
    
    //computed property that holds the total number of cells
    var cellCount: Int {
        return COLS*ROWS
    }
    
    //computed property holding the size of collectionView
    var cViewSize: CGSize {
        return self.collectionView!.frame.size
    }
    
    //computed property holding the value of the paraboloid parameter 'a'
    var a: CGFloat {
        return 2.5 * self.cViewSize.width
    }
    
    //computed property holding the value of the paraboloid parameter b
    var b: CGFloat {
        return 2.5 * self.cViewSize.height
    }
    //stored property holding the value of the paraboloid parameter c
    let c: CGFloat = 20
    
    //make the layout different each time
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    //calculating collectionView size according to content
    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake(self.itemSize * CGFloat(COLS) + self.cViewSize.width, self.itemSize * CGFloat(ROWS) + self.cViewSize.height)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        for i in 0 ..< cellCount {
            let indexPath = NSIndexPath(forItem: i, inSection: 0)
            attributes.append(self.layoutAttributesForItemAtIndexPath(indexPath)!)
        }
        return attributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes?
    {
        var attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        let oIndex = indexPath.item % COLS // 1
        let vIndex = (indexPath.item - oIndex) / COLS // 2
        
        var x = CGFloat(oIndex) * self.itemSize // 3
        var y = CGFloat(vIndex) * self.itemSize // 4
        
        if vIndex % 2 != 0 { // 5
            x += self.itemSize / 2.0
        }
        
        attributes.center = CGPoint(x: x, y: y) // 6
        
        let offset = self.collectionView!.contentOffset // 7
        x -= (self.center.x + CGFloat(offset.x)) // 8
        y -= (self.center.y + CGFloat(offset.y)) // 9
        
        x = -x*x/(a*a) // 10
        y = -y*y/(b*b) // 11
        var z = c * (x+y) + 1.0 // 12
        z = z < 0.0 ? 0.0 : z // 13
        
        attributes.transform = CGAffineTransformMakeScale(z, z) // 14
        attributes.size = CGSize(width: self.itemSize, height: self.itemSize) // 15
        
        return attributes
    }

    
}
