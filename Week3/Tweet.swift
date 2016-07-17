//
//  Tweet.swift
//  Week3
//
//  Created by Khang Le on 7/17/16.
//  Copyright © 2016 Khang Le. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCout: Int = 0
    
    init(dictionary:NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCout = (dictionary["favourites_count"] as? Int) ?? 0
        let timesString = dictionary["created_at"] as? String
        
        if let timesString = timesString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timesString)
        }
    }
    
    class func tweetsWithArray(dictinaries : [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictionary in dictinaries {
            let tweet = Tweet(dictionary : dictionary)
            tweets.append(tweet)
        }
        return tweets
    }

}
