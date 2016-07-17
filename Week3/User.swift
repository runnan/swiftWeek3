//
//  User.swift
//  Week3
//
//  Created by Khang Le on 7/17/16.
//  Copyright © 2016 Khang Le. All rights reserved.
//

import UIKit

class User: NSObject {
    var name:NSString?
    var screenName: NSString?
    var profileURL: NSURL?
    var tagline: NSString?
    
    init(dictinary : NSDictionary) {
        
        name = dictinary["name"] as? String
        screenName = dictinary["screen_name"] as? String
        let profileURLString = dictinary["profile_image_url_https"] as? String
        if(profileURLString != nil){
            profileURL = NSURL(string: profileURLString!)
        }
        
        
        tagline = dictinary["description"] as? String
    }
}
