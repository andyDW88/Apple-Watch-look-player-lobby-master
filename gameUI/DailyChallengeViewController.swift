//
//  DailyChallengeViewController.swift
//  gameUI
//
//  Created by MrD on 3/1/16.
//  Copyright © 2016 MrD. All rights reserved.
//

import UIKit

class DailyChallengeViewController: UIViewController {

    
    @IBOutlet var choices: UITableView!
    
    var sequences = ["A","B","C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cells = self.choices.dequeueReusableCellWithIdentifier("choices", forIndexPath: indexPath) as! choicesTableViewCell
        //cells.playerName.text = names[indexPath.row]
        cells.layer.cornerRadius = 10
        cells.backgroundColor = UIColor.lightGrayColor()
        cells.layer.borderWidth = 2.0
        cells.layer.borderColor = UIColor.whiteColor().CGColor
        //setting choices sequence
        cells.sequenceLbl.text = sequences[indexPath.row]
        //cells.actionBtn.addTarget(self, action: "selectAction", forControlEvents: .TouchUpInside)
        
        return cells
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
