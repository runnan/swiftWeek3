//
//  NewTweetViewController.swift
//  Week3
//
//  Created by Khang Le on 7/19/16.
//  Copyright © 2016 Khang Le. All rights reserved.
//

import UIKit


class NewTweetViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var fullnameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var user: User!
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Dispose of any resources that can be recreated.
        if(user.profileURL != nil){
            profileImage.setImageWithURL(user.profileURL!)
        }else{
            profileImage.image = UIImage.fontAwesomeIconWithName(.Cutlery, textColor: UIColor.blackColor(), size: CGSizeMake(90, 90))
        }
        fullnameLabel.text = user.name as! String
        usernameLabel.text = user.screenName as! String

    }
    
    
}
