//
//  ViewController.swift
//  SplitRoomBill
//
//  Created by girishbodhe on 22/09/18.
//  Copyright © 2018 girishbodhe. All rights reserved.
//

import UIKit
import Firebase
// Add this to the header of your file, e.g. in ViewController.m
// after #import "ViewController.h"
import FBSDKCoreKit
import FBSDKLoginKit


class ViewController: UIViewController,FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var logInButton: FBSDKLoginButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.logInButton.delegate = self

//        if (FBSDKAccessToken.currentAccessTokenIsActive()) {
//            // User is logged in, do work such as go to next view controller.
//            self.logInButton.alpha = 0
//        }else{
//            self.logInButton.alpha = 1
//        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error?) {
        if ((error) != nil) {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if error != nil {
                    // ...
                    return
                }
                // User is signed in
                // ...
            }
            // Navigate to other view
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
}

