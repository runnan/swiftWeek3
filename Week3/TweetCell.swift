//
//  TweetCell.swift
//  Week3
//
//  Created by Khang Le on 7/18/16.
//  Copyright © 2016 Khang Le. All rights reserved.
//

import UIKit
import AFNetworking
import FontAwesome_swift

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var tweet: Tweet!{
        didSet{
            if(tweet.creator!.profile != nil){
                profileImage.setImageWithURL(tweet.creator!.profile)
            }else{
                profileImage.image = UIImage.fontAwesomeIconWithName(.Cutlery, textColor: UIColor.blackColor(), size: CGSizeMake(90, 90))
            }
            fullNameLabel.text = tweet.creator!.fullName
            contentLabel.text = tweet.text
            screenNameLabel.text = "@" + tweet.creator!.screenName
            
            time.text = tweet.timestamp?.getElapsedInterval()
        }
    }
}


