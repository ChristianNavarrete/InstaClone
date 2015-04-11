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
    
    @IBAction func toggleSignup(sender: AnyObject) {
        
        
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
            
            loginButton.setTitle("Log In", forState: UIControlState.Normal)
            
            
        }

        
        
        
        
    }
    
    
    func displayAlert(title:String, error:String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
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

