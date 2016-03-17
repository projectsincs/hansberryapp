//
//  ViewController.swift
//  Sunflower
//
//  Created by Leonard Jones on 11/30/15.
//  Copyright © 2015 Leonard Jones. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userEmailAddressTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInButtonTapped(sender: AnyObject) {
        let userEmailAdress:String! = userEmailAddressTextField.text
        let userPassword:String! = userPasswordTextField.text
        
        if(userEmailAdress.isEmpty || userPassword.isEmpty){
            //alert with title
            let myAlert = UIAlertController(title: "Alert", message: "All fields are required to fill in", preferredStyle: UIAlertControllerStyle.Alert)
            //one button with ok and dissapears when clicked
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            //add button to alert
            myAlert.addAction(okAction)
            //present alert to user
            self.presentViewController(myAlert, animated: true, completion: nil)
            return
        }
        
        //activity indicator
        //create spinning activity and assign to variable
        let spinningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        spinningActivity.labelText = "Loading"
        spinningActivity.detailsLabelText = "Please wait"
        
        //now we know user address and password is entered
        //now to send the information to PHP script with 
        //a PHP script. 
        
        let myUrl = NSURL(string: "http://www.hansberrygarden.org/sunflowermobile/scripts/userSignin.php")
        //create url request
        let request = NSMutableURLRequest(URL: myUrl!)
        //set php method to post
        request.HTTPMethod = "POST"
        //create post string
        //need to implement HTTPS for SSL
        let postString = "userEmail=\(userEmailAdress)&userPassword=\(userPassword)";
        //send to server side script
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        //send http request
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            
            data, response, error in
            
            //to communicate with main thread
            dispatch_async(dispatch_get_main_queue()){
                
                //after response is received
                spinningActivity.hide(true)
                
                //check if there was an error
                if (error != nil) {
                    //alert with title
                    let myAlert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    //one button with ok and dissapears when clicked
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                    //add button to alert
                    myAlert.addAction(okAction)
                    //present alert to user
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    return
                }
                //if there was no error
                //get information from data object
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                    
                    if let parseJSON:NSDictionary = json {
                        let userID = parseJSON["userID"] as? String
                        if(userID != nil){
                            
                            //store user info in NSUserDefaults
                            //cannot store password in NSUDefaults for
                            //security information. 
                            NSUserDefaults.standardUserDefaults().setObject(parseJSON["userFirstName"], forKey: "userFirstName")
                            NSUserDefaults.standardUserDefaults().setObject(parseJSON["userLastName"], forKey: "userLastName")
                            NSUserDefaults.standardUserDefaults().setObject(parseJSON["userID"], forKey: "userID")
                            NSUserDefaults.standardUserDefaults().setObject(parseJSON["userEmail"], forKey: "userEmail")
                            NSUserDefaults.standardUserDefaults().setObject(parseJSON["userAddress"], forKey: "userAddress")
                            NSUserDefaults.standardUserDefaults().setObject(parseJSON["userPhoneNumber"], forKey: "userPhoneNumber")
                            NSUserDefaults.standardUserDefaults().setObject(parseJSON["userBedNumber"], forKey: "userBedNumber")
                            NSUserDefaults.standardUserDefaults().setObject(parseJSON["userJoinDate"], forKey: "userJoinDate")
                            
                            NSUserDefaults.standardUserDefaults().synchronize()
                            
                            //take user to main nav drawer
                            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                            appDelegate.buildNavigationDrawer()
                            
                        } else { //could not register user
                            //display an alert message
                            //alert with title
                            let userMessage = parseJSON["message"] as? String
                            let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                            //add button to alert
                            myAlert.addAction(okAction)
                            //present alert to user
                            self.presentViewController(myAlert, animated: true, completion: nil)
                        }
                    }
                } catch {
                    print(error)
                }
            }
            
            
        }
        
        task.resume()
    }

}

