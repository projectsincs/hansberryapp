//
//  MainPageViewController.swift
//  sunflower
//
//  Created by Leonard Jones on 12/5/15.
//  Copyright © 2015 Leonard Jones. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let userFirstName = NSUserDefaults.standardUserDefaults().stringForKey("userFirstName")
        let userLastName = NSUserDefaults.standardUserDefaults().stringForKey("userLastName")
        let userFullName = userFirstName! + " " + userLastName!
        userFullNameLabel.text = userFullName.capitalizedString
        
        //if user doesn't have user image set
        if(profilePhotoImageView.image == nil){
            //read user id
            let userID = NSUserDefaults.standardUserDefaults().stringForKey("userID")
            print(userID)
            //set url for image on server
            let imageURL = NSURL(string:"http://www.hansberrygarden.org/sunflowermobile/profile-pictures/\(userID!)/user-profile.jpg")
            //dispatch in sync task so app is still responsive
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                //pass image url to constructor
                let imageData = NSData(contentsOfURL: imageURL!)
                //make sure the image was successful
                if(imageData != nil){
                    dispatch_async(dispatch_get_main_queue(), {
                        //update profile image with a new image
                        //which is created from image data from server
                        self.profilePhotoImageView.image = UIImage(data: imageData!)
                    })
                }
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func selectProfilePhotoButtonTapped(sender: AnyObject) {
        //select profile picture from
        //photo library on device
        let myImagePicker = UIImagePickerController()
        myImagePicker.delegate = self
        myImagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(myImagePicker, animated: true, completion: nil)
    }
    
    //triggered when user chooses picture
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        //set profile picture image view as selected image
        profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
        
        //activity indicator
        //create spinning activity and assign to variable
        let spinningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        spinningActivity.labelText = "Uploading"
        spinningActivity.detailsLabelText = "uploading profile picture"
        
        myImageUploadRequest()
    }
    
    func myImageUploadRequest()
    {
        let myUrl = NSURL(string: "http://www.hansberrygarden.org/sunflowermobile/scripts/imageUpload.php");
        
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let userID:String? = NSUserDefaults.standardUserDefaults().stringForKey("userID")
        
        let param = [
            "userID" : userID!
        ]
        
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = UIImageJPEGRepresentation(profilePhotoImageView.image!, 1)
        
        if(imageData==nil)  { return; }
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            dispatch_async(dispatch_get_main_queue()){
                //hide all HUDS that are operating
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            }
            
            if error != nil {
                // Display an alert message
                return
            }
            
            do {
                
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                dispatch_async(dispatch_get_main_queue())
                    {
                        
                        if let parseJSON = json {
                            // let userId = parseJSON["userId"] as? String
                            
                            // Display an alert message
                            let userMessage = parseJSON["message"] as? String
                            self.displayAlertMessage(userMessage!)
                        } else {
                            // Display an alert message
                            let userMessage = "Could not upload image at this time"
                            self.displayAlertMessage(userMessage)
                        }
                }
            } catch
            {
                print(error)
            }
            
        }).resume()
        
        
        
    }
//    @IBAction func signOutButtonTapped(sender: AnyObject) {
//        //log out the user
//        //delete the information we know
//        //about the user and redirect
//        //to sign in page
//        
//        //delete info
//        NSUserDefaults.standardUserDefaults().removeObjectForKey("userFirstName")
//        NSUserDefaults.standardUserDefaults().removeObjectForKey("userLastName")
//        NSUserDefaults.standardUserDefaults().removeObjectForKey("userID")
//        NSUserDefaults.standardUserDefaults().synchronize()
//        
//        let signInPage = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
//        let signInNav = UINavigationController(rootViewController: signInPage)
//        let appDelegate = UIApplication.sharedApplication().delegate
//        appDelegate?.window??.rootViewController = signInNav
//        
//    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    func generateBoundaryString() -> String {
        // Create and return a unique string.
        return "Boundary-\(NSUUID().UUIDString)"
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

extension NSMutableData{
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}
