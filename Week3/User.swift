//
//  User.swift
//  Week3
//
//  Created by Khang Le on 7/17/16.
//  Copyright © 2016 Khang Le. All rights reserved.
//

import UIKit

class User: NSObject {
    static let userDidLogoutNotification = "UserDidLogout"
    var name:NSString?
    var screenName: NSString?
    var profileURL: NSURL?
    var tagline: NSString?
    
    var dictionary : NSDictionary?
    
    init(dictinary : NSDictionary) {
        self.dictionary = dictinary
        name = dictinary["name"] as? String
        screenName = dictinary["screen_name"] as? String
        let profileURLString = dictinary["profile_image_url_https"] as? String
        if(profileURLString != nil){
            profileURL = NSURL(string: profileURLString!)
        }
        tagline = dictinary["description"] as? String
    }
    
    static var _currentUser : User?
    
    class var currentUser: User?{
        get {
            if(_currentUser == nil){
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUserData") as? NSData
                if let userData = userData{
                    let dict = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser  = User(dictinary: dict)
                }
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user{
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            }else{
                defaults.setObject(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
}
