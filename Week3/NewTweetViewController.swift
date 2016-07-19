//
//  NewTweetViewController.swift
//  Week3
//
//  Created by Khang Le on 7/19/16.
//  Copyright © 2016 Khang Le. All rights reserved.
//

import UIKit

@objc protocol NewTweetViewControllerDelegate {
    optional func newTweetViewControllerDelegate (newTweetViewController:NewTweetViewController, didAddNewTweet result : Bool)
}

class NewTweetViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var fullnameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var user: User!

    let maxLength:Int = 140
    
    @IBOutlet weak var contentTxt: UITextView!
    @IBOutlet weak var count: UIBarButtonItem!
    
    weak var delegate:NewTweetViewControllerDelegate?
    @IBAction func onNewTweet(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        var result = false
        TwitterClient.sharedInstance.postStatusUpdate(contentTxt.text!, success: {
            result = true
            self.delegate?.newTweetViewControllerDelegate?(self,didAddNewTweet : result)
            }) { (error:NSError) in
            print(error)
            result = true
            self.delegate?.newTweetViewControllerDelegate?(self,didAddNewTweet : result)
        }
    }
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
        fullnameLabel.text = user.name as?String
        usernameLabel.text = user.screenName as? String
        
        contentTxt.delegate = self
        count.title = String(maxLength)
    }
}

extension NewTweetViewController : UITextFieldDelegate{
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool
    {
        let currentString: NSString = contentTxt.text!
        let newString: NSString =
            currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
}

extension NewTweetViewController : UITextViewDelegate{
    func textViewDidChange(textView: UITextView) { //Handle the text changes here
        count.title = String(maxLength - contentTxt.text!.characters.count)
    }
}


