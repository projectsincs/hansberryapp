//
//  AboutViewController.swift
//  sunflower
//
//  Created by Leonard Jones on 12/6/15.
//  Copyright © 2015 Leonard Jones. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var user = [User]()
    
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
        case 0: let userNameCell = tableView.dequeueReusableCellWithIdentifier("userNameCell", forIndexPath: indexPath)
                let userFirstName = NSUserDefaults.standardUserDefaults().stringForKey("userFirstName")
                let userLastName = NSUserDefaults.standardUserDefaults().stringForKey("userLastName")
                let userFullName = userFirstName! + " " + userLastName!
                userNameCell.textLabel?.text = userFullName
                return userNameCell
        case 1:
                let userAddressCell = tableView.dequeueReusableCellWithIdentifier("userAddressCell", forIndexPath: indexPath)
                let userAddress = NSUserDefaults.standardUserDefaults().stringForKey("userAddress")
                userAddressCell.textLabel?.text = userAddress
                return userAddressCell
        case 2: let userPhoneNumberCell = tableView.dequeueReusableCellWithIdentifier("userPhoneNumberCell", forIndexPath: indexPath)
                let userPhoneNumber = NSUserDefaults.standardUserDefaults().stringForKey("userPhoneNumber")
                userPhoneNumberCell.textLabel?.text = userPhoneNumber
                return userPhoneNumberCell
        case 3: let userEmailCell = tableView.dequeueReusableCellWithIdentifier("userEmailCell", forIndexPath: indexPath)
                let userEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")
                userEmailCell.textLabel?.text = userEmail
                return userEmailCell
        case 4: let userJoinDateCell = tableView.dequeueReusableCellWithIdentifier("userJoinDateCell", forIndexPath: indexPath)
                let userJoinDate = NSUserDefaults.standardUserDefaults().stringForKey("userJoinDate")
                userJoinDateCell.textLabel?.text = userJoinDate
        print(userJoinDate)
                return userJoinDateCell
        case 5: let userBedNumberCell = tableView.dequeueReusableCellWithIdentifier("userBedNumberCell", forIndexPath: indexPath)
                let userBedNumber = NSUserDefaults.standardUserDefaults().stringForKey("userBedNumber")
                userBedNumberCell.textLabel?.text = userBedNumber
                return userBedNumberCell
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
