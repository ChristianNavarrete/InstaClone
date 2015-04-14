//
//  ViewController.swift
//  InstaClone
//
//  Created by HoodsDream on 4/10/15.
//  Copyright (c) 2015 HoodsDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var signupLabel: UILabel!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var alreadyRegisteredLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    
    var signupActive = true
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    

    @IBAction func toggleSignUp(sender: AnyObject) {
        
        if signupActive == true {
            
            signupActive = false
            
            signupLabel.text = "Use the form below to log in"
            
            signupButton.setTitle("Log In", forState: UIControlState.Normal)
            
            alreadyRegisteredLabel.text = "Not Registered?"
            
            loginButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            
        } else {
            
            signupActive = true
            
            signupLabel.text = "Use the form below to sign up"
            
            signupButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            alreadyRegisteredLabel.text = "Already Registered?"
            
            loginButton.setTitle("Login", forState: UIControlState.Normal)
            
            
        }
        
    }
    
    
    func displayAlert(title:String, error:String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    

    
    @IBAction func signup(sender: AnyObject) {
        
        var error = ""
        
        if username.text == "" || password.text == "" {
            
            error = "Please enter a username and password"
            
        }
        
        
        if error != "" {
            
            displayAlert("Error In Form", error: error)
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            if signupActive == true {
                
                var user = PFUser()
                user.username = username.text
                user.password = password.text
                
                user.signUpInBackgroundWithBlock {
                    (succeeded: Bool!, signupError: NSError!) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if signupError == nil  {
                        // Hooray! Let them use the app now.
                        
                        println("signed up")
                        
                        
                    } else {
                        if let errorString = signupError.userInfo?["error"] as? NSString {
                            
                            // Update - added as! String
                            
                            error = errorString as String!
                            
                        } else {
                            
                            error = "Please try again later."
                            
                        }
                        
                        self.displayAlert("Could Not Sign Up", error: error)
                        
                    }
                }
                
            } else {
                
                PFUser.logInWithUsernameInBackground(username.text, password:password.text) {
                    (user: PFUser!, signupError: NSError!) -> Void in
                    
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if signupError == nil {
                        
                        println("logged in")
                        
                        self.performSegueWithIdentifier("jumpToUserTable", sender: self)
                        
                    } else {
                        
                        if let errorString = signupError.userInfo?["error"] as? NSString {
                            
                            // Update - added as! String
                            
                            error = errorString as String!
                            
                        } else {
                            
                            error = "Please try again later."
                            
                        }
                        
                        self.displayAlert("Could Not Log In", error: error)
                        
                        
                    }
                }
                
                
            }
            
            
        }

        
    }
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            
            self.performSegueWithIdentifier("jumpToUserTable", sender: self)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
        
    }
    

    
    
    
    
    
    
    
    
    
    
    
    


}

