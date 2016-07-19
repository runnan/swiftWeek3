//
//  Tweet.swift
//  Week3
//
//  Created by Khang Le on 7/17/16.
//  Copyright © 2016 Khang Le. All rights reserved.
//

import UIKit
import AFNetworking

class Tweet: NSObject {
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCout: Int = 0
    
    var creator : Creator?
    
    
    
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
        
        creator = Creator(dictionary: dictionary)
    }
    
    class func tweetsWithArray(dictinaries : [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictionary in dictinaries {
            let tweet = Tweet(dictionary : dictionary)
            print(tweet)
            tweets.append(tweet)
        }
        return tweets
    }
    
    // Creates a text representation of a GitHub repo
    override var description: String {
        
        return "[text: \(self.text)]" +
            "\n\t[timestamp: \(self.timestamp)]" +
            "\n\t[retweetCount: \(self.retweetCount)]" +
            "\n\t[favoritesCout: \(self.favoritesCout)]"
        
        //return ""
    }


}
extension NSDate {
    
    func getElapsedInterval() -> String {

        var interval = NSCalendar.currentCalendar().components(.Day, fromDate: self, toDate: NSDate(), options: []).day
        if interval > 0 {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.stringFromDate(self)
        }
        
        interval = NSCalendar.currentCalendar().components(.Hour, fromDate: self, toDate: NSDate(), options: []).hour
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "hour" :
                "\(interval)" + " " + "hours"
        }
        
        interval = NSCalendar.currentCalendar().components(.Minute, fromDate: self, toDate: NSDate(), options: []).minute
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "minute" :
                "\(interval)" + " " + "minutes"
        }
        
        interval = NSCalendar.currentCalendar().components(.Second, fromDate: self, toDate: NSDate(), options: []).second
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "second" :
                "\(interval)" + " " + "seconds"
        }
        
        return "a moment ago"
    }
}