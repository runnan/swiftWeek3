//
//  TwitterClient.swift
//  Week3
//
//  Created by Khang Le on 7/17/16.
//  Copyright © 2016 Khang Le. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "vMwrxxVgS0MTJkNzEJXRNg1lB", consumerSecret: "SGzm0CL51zIVWaR6G6Ne4A5cY5i6OBg4ddH6av73Kp0H5Q3G1s")
    
    var loginSuccess: (() -> ())?
    var loginFailure : ((NSError) -> ())?
    
    func login(success: () -> (), failure : (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken : BDBOAuth1Credential!) -> Void in
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
        }) { (error : NSError!) -> Void in
            print("error")
            self.loginFailure?(error)
        }
    }
    
    func homeTimeLine(success: ([Tweet]) -> (), failure : (NSError) -> ()){
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task : NSURLSessionDataTask, response : AnyObject?) in
            print("accouut\(response)")
            let dics = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dics)
            
            success(tweets)
            }, failure: { (task : NSURLSessionDataTask?, error : NSError) in
                failure(error)
        })
    }
    
    func currentAccount(success: (User) -> (), failure : (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task : NSURLSessionDataTask, response : AnyObject?) in
            let userDic = response as! NSDictionary
            let user = User(dictinary: userDic)
            
            success(user)
            }, failure: { (task : NSURLSessionDataTask?, error : NSError) in
                failure(error)
        })
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken : BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user:User) in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error : NSError) in
                    self.loginFailure?(error)
            })
            
        }) { (error : NSError!) -> Void in
            print("error")
            self.loginFailure?(error)
        }

    }
}
