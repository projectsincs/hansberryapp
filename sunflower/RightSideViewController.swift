//
//  RightSideViewController.swift
//  sunflower
//
//  Created by Leonard Jones on 12/6/15.
//  Copyright © 2015 Leonard Jones. All rights reserved.
//

import UIKit

class RightSideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var menuItems:[String] = ["Add Member","Delete Member","View Members"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //populate the table view with the number of members returned
    func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("adminMenuCell", forIndexPath: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath){
        switch(indexPath.row){
        case 0: //tapped Add Member
            //instantiate add member controller
            let addMemberPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AddMemberViewController") as! AddMemberViewController
            //wrap in navigation controller
            let addMemberPageNav = UINavigationController(rootViewController: addMemberPageViewController)
            //set nav controller to navigation drawer
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            //toggle right side panel
            appDelegate.drawerContainer!.centerViewController = addMemberPageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Right, animated: true, completion: nil)
            break
        case 1: break
        case 2: //tapped view members
            //instantiate add member controller
            let memberListPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MemberListViewController") as! MemberListViewController
            //wrap in navigation controller
            let viewMemberListPageNav = UINavigationController(rootViewController: memberListPageViewController)
            //set nav controller to navigation drawer
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            //toggle right side panel
            appDelegate.drawerContainer!.centerViewController = viewMemberListPageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Right, animated: true, completion: nil)
            break

        default:
            print("Not handled")
            
        }
    }
   

}
