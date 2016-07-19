//
//  Creator.swift
//  Week3
//
//  Created by Khang Le on 7/19/16.
//  Copyright © 2016 Khang Le. All rights reserved.
//

import UIKit

class Creator: NSObject {
    var fullName:String!
    var profile:NSURL!
    var screenName:String!
    
    init(dictionary:NSDictionary) {
        fullName = dictionary["user"]!["name"] as? String
        let imageURLString = dictionary["user"]!["profile_image_url"] as? String
        if imageURLString != nil {
            profile = NSURL(string: imageURLString!)!
        } else {
            profile = nil
        }
        screenName = dictionary["user"]!["screen_name"] as? String
    }
    
    override var description: String {
        
        return "\n\t[fullName: \(self.fullName)]" +
            "\n\t[profile: \(self.profile)]" +
            "\n\t[screenName: \(self.screenName)]"
        
        //return ""
    }

}
