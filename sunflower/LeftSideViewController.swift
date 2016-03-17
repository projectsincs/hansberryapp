//
//  LeftSideViewController.swift
//  sunflower
//
//  Created by Leonard Jones on 12/6/15.
//  Copyright © 2015 Leonard Jones. All rights reserved.
//

import UIKit

class LeftSideViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    var menuItems:[String] = ["Dashboard","My Profile","Sign Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {   //returns number of rows in table view
        //only one section with three rows
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let myCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        
        myCell.textLabel?.text = menuItems[indexPath.row]
        
        return myCell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        switch(indexPath.row){
        case 0:
            //tapped on Main page
            //instantiate main page view controller
            let mainPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainPageViewController") as! MainPageViewController
            //wrap in navigation controller
            let mainPageNav = UINavigationController(rootViewController: mainPageViewController)
            //set nav controller to navigation drawer
            //need reference to app delegate sine nav drawer was 
            //created in app delegate
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            //toggle left side panel
            appDelegate.drawerContainer!.centerViewController = mainPageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
        case 1:
            print("test")
            let aboutViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
            //create navigation controller with aboutViewController as it's root controller
            let aboutPageNav = UINavigationController(rootViewController: aboutViewController)
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = aboutPageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
            break
        case 2:
            //sign out cell was tapped
            //forget user info
            NSUserDefaults.standardUserDefaults().removeObjectForKey("userFirstName")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("userLastName")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("userID")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("userEmail")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("userAddress")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("userPhoneNumber")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("userBedNumber")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("userJoinDate")
            NSUserDefaults.standardUserDefaults().synchronize()
            //instantiate  viewcontroller which is sign in page
            let signInPage = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            
            let signInNav = UINavigationController(rootViewController: signInPage)
            
            let appDelegate = UIApplication.sharedApplication().delegate
            appDelegate?.window??.rootViewController = signInNav
            
            break
            
        default:
            print("Not handled")
        }
    }

    

}
