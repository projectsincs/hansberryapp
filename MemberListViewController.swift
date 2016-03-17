//
//  MemberListViewController.swift
//  sunflower
//
//  Created by Leonard Jones on 12/7/15.
//  Copyright © 2015 Leonard Jones. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var members = [Member]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = NSURL(string: "http://hansberrygarden.org/sunflowermobile/scripts/returnAllUsers.php")
        if let JSONData = NSData(contentsOfURL: myURL!){
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(JSONData, options: NSJSONReadingOptions.MutableContainers)
                for anItem in json as! [Dictionary<String, AnyObject>]{
                    members.append(Member(json: anItem))
                }
            } catch let error as NSError{
                print("Failed to load: \(error.localizedDescription)")
            }
            
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {   //returns number of rows in table view
        return members.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemberListCell", forIndexPath: indexPath)
        cell.textLabel?.text = members[indexPath.row].firstName! + " " + members[indexPath.row].lastName!
        cell.detailTextLabel?.text = members[indexPath.row].bedNumber
        return cell
     }


    @IBAction func rightSideButtonTapped(sender: AnyObject) {
        //in order to access app drawer create reference to project's app delegate
        //since nav drawer was created in app delegate
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Right, animated: true, completion: nil)
    }
    
    @IBAction func leftSideButtonTapped(sender: AnyObject) {
        //in order to access app drawer create reference to project's app delegate
        //since nav drawer was created in app delegate
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let memberDetailViewController = segue.destinationViewController as! MemberDetailViewController
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let index = myIndexPath.row
            let selectedMember = members[index]
//            memberDetailViewController.member = selectedMember
            
        }
    }
    

}
