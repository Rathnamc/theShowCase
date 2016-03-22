//
//  ViewController.swift
//  theShowCase
//
//  Created by Christopher Rathnam on 3/19/16.
//  Copyright © 2016 Christopher Rathnam. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class LoginVC: UIViewController {
    
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
        
       
        
    }

    @IBAction func fbBtnPressed(sender: UIButton!){
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self) { ( facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else if facebookResult.isCancelled {
                print("Login was Cancelled.")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully Logged in with facebook. \(accessToken)")
                
                //oAuth Authentication
                DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
                    
                    
                    if error != nil {
                        print("Login Failed. \(error)")
                    } else {
                        print("Logged In!\(authData)")
                        
                        //Save onto new Firebase account
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                        //If successful segue into new VC
                        
                        print("======UID View for Key")
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                })
            }
        }
    }
    

    @IBAction func attemptLogin(sender: UIButton!) {
     
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
            
            DataService.ds.REF_BASE.authUser(email, password: pwd) { error, authData in
                
                if error != nil {
                    
                    print(error.code)
                    
                    if error.code == STATUS_ACCOUNT_NONEXIST {
                        DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { error, result in
                            
                            if error != nil {
                                self.showErrorAlert("Could not Create Account", msg: "Try Again!")
                                
                            } else {
                                
                                let uid = result["uid"] as? String
                                NSUserDefaults.standardUserDefaults().setValue(uid, forKey: KEY_UID)
                                
                                DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: nil)
                                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                            }
                            
                        })
                        
                    } else {
                        self.showErrorAlert("Could not Login", msg: "Please check Username or Password")
                    }
                    
                } else {
                   self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
            }
            
        } else {
            showErrorAlert("Email and Password Required", msg: "You must enter an email and password")
            
        }
        
    }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
}


/*
let facebookLogin = FBSDKLoginManager()

facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult, facebookError) -> Void in
    
    if facebookError != nil {
        print("Facebook login failed. Error \(facebookError)")
    } else {
        let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
        print("Successfully logged in with facebook. \(accessToken)")
        
        //OAuth Authentication
        
        
    }
}
*/