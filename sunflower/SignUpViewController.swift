//
//  SignUpViewController.swift
//  Sunflower
//
//  Created by Leonard Jones on 11/30/15.
//  Copyright © 2015 Leonard Jones. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userEmailAddressTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userPasswordRepeatTextField: UITextField!
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userAddressTextField: UITextField!
    @IBOutlet weak var userPhoneNumberTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    @IBAction func signUpButtonTapped(sender: AnyObject) {
        let userEmail:String! = userEmailAddressTextField.text
        let userPassword:String! = userPasswordTextField.text
        let userPasswordRepeat:String! = userPasswordRepeatTextField.text
        let userFirstName:String! = userFirstNameTextField.text
        let userLastName:String! = userLastNameTextField.text
        let userAddress:String! = userAddressTextField.text
        let userPhoneNumber:String! = userPhoneNumberTextField.text
        
        //check if user password equals repeat password
        if(userPassword != userPasswordRepeat){
            //Display alert message
            displayAlertMessage("Passwords do not match")
            return
        }
        
        //check that fields are filled in
        if(userEmail.isEmpty || userPassword.isEmpty
            || userPasswordRepeat.isEmpty
            || userFirstName.isEmpty || userLastName.isEmpty || userAddress.isEmpty || userPhoneNumber.isEmpty){
            //Display an alert message
            displayAlertMessage("All fields are required")
            return
        }
        
        //activity indicator
        //create spinning activity and assign to variable
        let spinningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        spinningActivity.labelText = "Loading"
        spinningActivity.detailsLabelText = "Please wait"
        
        //send request to server
        //pass http address to registration php script
        let myURL = NSURL(string: "http://www.hansberrygarden.org/sunflowermobile/scripts/registerUser.php");
        let request = NSMutableURLRequest(URL:myURL!);
        request.HTTPMethod = "POST";
        
        //set HTTP body with parameters from sign up
        //using php key value pattern
        let postString = "userEmail=\(userEmail)&userFirstName=\(userFirstName)&userLastName=\(userLastName)&userAddress=\(userAddress)&userPhoneNumber=\(userPhoneNumber)&userPassword=\(userPassword)";
        print(postString)
        
        //attach string to http body
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        //send http request
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            
            data, response, error in
            
            //to communicate with main thread
            dispatch_async(dispatch_get_main_queue()){
                //after response is received
                spinningActivity.hide(true)
                
                //check if there was an error
                if (error != nil) {
                    self.displayAlertMessage(error!.localizedDescription)
                }
                print("hello")
                //if there was no error
                //get information from data object
                do {
                    print(data)
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                    
                    if let parseJSON:NSDictionary = json {
                        let userID = parseJSON["userID"] as? String
                        if(userID != nil){
                            //completion handler to dismiss sign up view controller too.
                            self.displayAlertMessageAndDismissController("Registration Successful")
                        } else { //could not register user
                            let errorMessage = parseJSON["message"] as? String
                            if(errorMessage != nil){
                                self.displayAlertMessage(errorMessage!)
                            }
                        }
                    }
                } catch {
                    print(error)
                }
            }

            
        }
        
        task.resume()
        
    }
    
    func displayAlertMessage(userMessage:String){
        let myAlert = UIAlertController(title: "Alert", message:
            userMessage, preferredStyle:  UIAlertControllerStyle.Alert);
        //ok button
        let okAction = UIAlertAction(title: "OK", style:UIAlertActionStyle.Default, handler:nil)
        //add ok button
        myAlert.addAction(okAction);
        //present dialog
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    func displayAlertMessageAndDismissController(message:String){
        let myAlert = UIAlertController(title: "Alert", message:
            message, preferredStyle:  UIAlertControllerStyle.Alert);
        //ok button
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){(action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        //add ok button
        myAlert.addAction(okAction);
        //present dialog
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    

}
