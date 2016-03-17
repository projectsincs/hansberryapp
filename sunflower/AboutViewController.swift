//
//  AboutViewController.swift
//  sunflower
//
//  Created by Leonard Jones on 12/6/15.
//  Copyright © 2015 Leonard Jones. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var member = [Member]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {   //returns number of rows in table view
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        switch(indexPath.row){
        case 0: let memberNameCell = tableView.dequeueReusableCellWithIdentifier("memberNameCell", forIndexPath: indexPath)
                let userFirstName = NSUserDefaults.standardUserDefaults().stringForKey("userFirstName")
                let userLastName = NSUserDefaults.standardUserDefaults().stringForKey("userLastName")
                let userFullName = userFirstName! + " " + userLastName!
                memberNameCell.textLabel?.text = userFullName
                return memberNameCell
        case 1:
                let memberAddressCell = tableView.dequeueReusableCellWithIdentifier("memberAddressCell", forIndexPath: indexPath)
                let userAddress = NSUserDefaults.standardUserDefaults().stringForKey("userAddress")
                memberAddressCell.textLabel?.text = userAddress
                return memberAddressCell
        case 2: let memberPhoneNumberCell = tableView.dequeueReusableCellWithIdentifier("memberPhoneNumberCell", forIndexPath: indexPath)
                let userPhoneNumber = NSUserDefaults.standardUserDefaults().stringForKey("userPhoneNumber")
                memberPhoneNumberCell.textLabel?.text = userPhoneNumber
                return memberPhoneNumberCell
        case 3: let memberEmailCell = tableView.dequeueReusableCellWithIdentifier("memberEmailCell", forIndexPath: indexPath)
                let userEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
                memberEmailCell.textLabel?.text = userEmail
                return memberEmailCell
        case 4: let memberJoinDateCell = tableView.dequeueReusableCellWithIdentifier("memberJoinDateCell", forIndexPath: indexPath)
                let userJoinDate = NSUserDefaults.standardUserDefaults().stringForKey("userJoinDate")
                memberJoinDateCell.textLabel?.text = userJoinDate
        print(userJoinDate)
                return memberJoinDateCell
        case 5: let memberBedNumberCell = tableView.dequeueReusableCellWithIdentifier("memberBedNumberCell", forIndexPath: indexPath)
                let userBedNumber = NSUserDefaults.standardUserDefaults().stringForKey("userBedNumber")
                memberBedNumberCell.textLabel?.text = userBedNumber
                return memberBedNumberCell
        default:
            print("Error building prototype cells")
        }
        return UITableViewCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leftSideButtonTapped(sender: AnyObject) {
        //in order to access app drawer create reference to project's app delegate
        //since nav drawer was created in app delegate
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }

    @IBAction func rightSideButtonTapped(sender: AnyObject) {
        //in order to access app drawer create reference to project's app delegate
        //since nav drawer was created in app delegate
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Right, animated: true, completion: nil)
    }

}
