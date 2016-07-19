//
//  TweetDetailViewController.swift
//  Week3
//
//  Created by Khang Le on 7/19/16.
//  Copyright © 2016 Khang Le. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernamLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    var tweet:Tweet!
    
    @IBAction func onBackToHome(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(tweet.creator!.profile != nil){
            profileImage.setImageWithURL(tweet.creator!.profile)
        }else{
            profileImage.image = UIImage.fontAwesomeIconWithName(.Cutlery, textColor: UIColor.blackColor(), size: CGSizeMake(90, 90))
        }
        fullNameLabel.text = tweet.creator!.fullName
        contentLabel.text = tweet.text
        usernamLabel.text = "@" + tweet.creator!.screenName
        timeLabel.text = tweet.timestamp?.description
        retweetCountLabel.text = "\(tweet.retweetCount.description) RETWEETS"
        favoriteCountLabel.text = "\(tweet.favoritesCout.description) FAVORITES"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
