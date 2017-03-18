//
//  ViewController.swift
//  gameUI
//
//  Created by MrD on 1/28/16.
//  Copyright © 2016 MrD. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

let COLS = 90
let ROWS = 90
let cellCount = COLS*ROWS
private var longPressGesture: UILongPressGestureRecognizer!
private var numbers: [Int] = []

//@available(iOS 9.0, *)
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIPopoverPresentationControllerDelegate {
   
    @IBOutlet var collectionView: UICollectionView!
    var dict : NSDictionary!
    
    @IBOutlet var dailyChallengeBtn: UIButton!
    //Network data plugin needed: user profile pic, energy(score) display
    
    @IBOutlet var userProfilePic: UIImageView!
    @IBOutlet weak var userEngLbl: UILabel!
    
    private let cellIdentifier = "collectionView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerNib(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:cellIdentifier)
        
        //buttom bar user profile
        roundUserProfilepic()
        userProfilePic.image = UIImage(named: "fbICN.png")
        getFBUserData()
        
        //setting layout (applying the watch ui)
        self.collectionView.collectionViewLayout = CollectionViewLayout()
        
        //adding gestures
        let tap = UIPinchGestureRecognizer(target: self, action: "pinchDetected:")
        
        collectionView.addGestureRecognizer(tap)
        
        dailyChallengeBtn.layer.cornerRadius = 30
        dailyChallengeBtn.clipsToBounds = true
        
        
        //just a test
        for _ in 0...100 {
            let height = Int(arc4random_uniform((UInt32(100)))) + 40
            numbers.append(height)
        }

        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleLongGesture:")
        self.collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @available(iOS 9.0, *)
    func handleLongGesture(gesture: UILongPressGestureRecognizer){
        switch(gesture.state){
        case UIGestureRecognizerState.Began:
            guard let selectedIndexPath = self.collectionView.indexPathForItemAtPoint(gesture.locationInView(self.collectionView))else{
                break
            }
            if #available(iOS 9.0, *) {
                collectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
            } else {
                // Fallback on earlier versions
            }
        case UIGestureRecognizerState.Changed:
            if #available(iOS 9.0, *) {
                collectionView.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
            } else {
                // Fallback on earlier versions
            }
        case UIGestureRecognizerState.Ended:
            if #available(iOS 9.0, *) {
                collectionView.endInteractiveMovement()
            } else {
                // Fallback on earlier versions
            }
        default:
            if #available(iOS 9.0, *) {
                collectionView.cancelInteractiveMovement()
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    func pinchDetected(recognizer:UIPinchGestureRecognizer){
        guard let view = recognizer.view else {return}
        view.transform = CGAffineTransformScale(view.transform, recognizer.scale, recognizer.scale)
        recognizer.scale = 1.0
    }
    
    func roundUserProfilepic () {
        userProfilePic.layer.cornerRadius = 35
        userProfilePic.clipsToBounds = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount    
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
        collectionView.setZoomScale(4.0, animated: true)
        
        cell.imageView.image = UIImage(named: "cat_\(indexPath.row%10)")
        
        return cell
    }
    
    func backGroundColor () {
        self.collectionView.backgroundColor = UIColor.clearColor()
    }
    
        
   
    func getFBUserData(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! NSDictionary
                    print(result)
                    print(self.dict)
                    NSLog(self.dict.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String)
                    
                    let FBid = result.valueForKey("id") as? String
                    
                    let url = NSURL(string: "https://graph.facebook.com/\(FBid!)/picture?type=large&return_ssl_resources=1")
                    self.userProfilePic.image = UIImage(data: NSData(contentsOfURL: url!)!)
                }
            })
            
        }
    }
}

extension ViewController: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView (collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: Int((view.bounds.width - 40)/3), height: numbers[indexPath.item])
    }
}

@available(iOS 9.0, *)
extension CHTCollectionViewWaterfallLayout {
    
    internal override func invalidationContextForInteractivelyMovingItems(targetIndexPaths: [NSIndexPath], withTargetPosition targetPosition: CGPoint, previousIndexPaths: [NSIndexPath], previousPosition: CGPoint) -> UICollectionViewLayoutInvalidationContext {
        
        let context = super.invalidationContextForInteractivelyMovingItems(targetIndexPaths, withTargetPosition: targetPosition, previousIndexPaths: previousIndexPaths, previousPosition: previousPosition)
        
        self.delegate?.collectionView!(self.collectionView!, moveItemAtIndexPath: previousIndexPaths[0], toIndexPath: targetIndexPaths[0])
        
        return context
    }
}


