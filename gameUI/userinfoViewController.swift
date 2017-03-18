//
//  userinfoViewController.swift
//  gameUI
//
//  Created by MrD on 2/19/16.
//  Copyright © 2016 MrD. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class userinfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var inviteBtn: UIButton!
    @IBOutlet weak var fbSharebtn: UIButton!
    @IBOutlet weak var userProfilePic: UIImageView!
    
    var dict : NSDictionary!
    
    var names = ["Tom","Mark","Jane","Mary","Rose","Alice","Peter","Jessica"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inviteBtn.layer.cornerRadius = 15
        fbSharebtn.layer.cornerRadius = 15
        userProfilePic.layer.cornerRadius = 32
        userProfilePic.clipsToBounds = true
        getFBUserData() 
        
        inviteBtn.addTarget(self, action: "inviteBtnTapped", forControlEvents: .TouchUpInside)
    }
    
    func inviteBtnTapped () {
        print("i am tapped")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cells = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        cells.playerName.text = names[indexPath.row]
        cells.layer.cornerRadius = 10
        cells.backgroundColor = UIColor.lightGrayColor()
        cells.layer.borderWidth = 2.0
        cells.layer.borderColor = UIColor.whiteColor().CGColor
        return cells
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
