//
//  PostViewController.swift
//  InstaClone
//
//  Created by HoodsDream on 4/13/15.
//  Copyright (c) 2015 HoodsDream. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photoSelected:Bool = false
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title:String, error:String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action -> Void in
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.shareText.resignFirstResponder()
    }
    
    
    @IBOutlet weak var imageToPost: UIImageView!
    
    @IBAction func chooseImage(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion:nil)
        
    }
    
    @IBOutlet weak var shareText: UITextField!
    
    @IBAction func postImage(sender: AnyObject) {
        
        var error = ""
        
        if (photoSelected == false) {
            
            error = "please select an image"
            
        } else if (shareText.text == "") {
            
            error = "please enter a caption for your image"
            
        }
        
        if (error != "") {
            
            displayAlert("Error:", error: error)
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            
            var post = PFObject(className: "Post")
            post["Title"] = shareText.text
            post["Username"] = PFUser.currentUser().username
            
            post.saveInBackgroundWithBlock {(success:Bool!, error:NSError!) -> Void in
                
                if success == false {
                    
                    self.displayAlert("Error", error:"please try again later")
                    
                } else {
                    
                    let imageData = UIImagePNGRepresentation(self.imageToPost.image)
                    let imageFile = PFFile(name: "image.png", data: imageData)
                    
                    post["imageFile"] = imageFile
                    
                    post.saveInBackgroundWithBlock {(success:Bool!, error:NSError!) -> Void in
                        
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        
                        if success == false {
                            
                            self.activityIndicator.stopAnimating()
                            UIApplication.sharedApplication().endIgnoringInteractionEvents()
                            
                            self.displayAlert("Error", error:"please try again later")
                            
                        } else {
                            
                            self.displayAlert("Yay!", error: "Your image has been posted successfully")
                            
                            self.photoSelected = false
                            
                            self.imageToPost.image = UIImage(named: "blank.png")
                            
                            self.shareText.text = ""
                            
                        }
                
                    }
            
            
                }
        
            }
        }
        
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("image selected")
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        imageToPost.image = image
        
        photoSelected = true

        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        photoSelected = false
        
        imageToPost.image = UIImage(named: "blank.png")
        
        shareText.text = ""
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
    
    

}
