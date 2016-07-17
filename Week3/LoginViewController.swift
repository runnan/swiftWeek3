//
//  LoginViewController.swift
//  Week3
//
//  Created by Khang Le on 7/17/16.
//  Copyright © 2016 Khang Le. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.login({
            print("already loggin")
            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }) { (error : NSError) in
            print(error.localizedDescription)
        }
    }
}
