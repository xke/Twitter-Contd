//
//  Tweet.swift
//  Twitter
//
//  Created by Xian on 10/3/15.
//  Copyright © 2015 swifterlabs. All rights reserved.
//

import UIKit


class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var idStr: String? // used for infinite loading
    
    init(dictionary: NSDictionary) {
        
        // api reference: https://dev.twitter.com/rest/reference/post/statuses/update

        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        idStr = dictionary["id_str"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        // and spit back the string in a more readable form!
        formatter.dateFormat = "EEE MMM d, y - HH:mm a"
        createdAtString = formatter.stringFromDate(createdAt!)
        
        
    }
    
    class func formatTimeElapsed(sinceDate: NSDate) -> String {
        let formatter = NSDateComponentsFormatter()
        formatter.unitsStyle = NSDateComponentsFormatterUnitsStyle.Abbreviated
        formatter.collapsesLargestUnit = true
        formatter.maximumUnitCount = 1
        let interval = NSDate().timeIntervalSinceDate(sinceDate)
        return formatter.stringFromTimeInterval(interval)!
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
            
        }
        
        return tweets
    }
    
    
}
