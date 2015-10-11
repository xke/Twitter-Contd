//
//  User.swift
//  Twitter
//
//  Created by Xian on 10/3/15.
//  Copyright © 2015 swifterlabs. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"

let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

// api reference: https://dev.twitter.com/rest/reference/get/users/show

class User: NSObject {
    var name: String?
    var screenname: String?
    
    var profileImageUrl: String?
    var profileBannerUrl: String?

    var tagline: String?
    var dictionary: NSDictionary
    
    var followerCount: Int?
    var followingCount: Int?
    var tweetCount: Int?
    
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        profileImageUrl = dictionary["profile_image_url"] as? String
        profileImageUrl = profileImageUrl!.stringByReplacingOccurrencesOfString("_normal", withString: "_bigger")
        
        profileBannerUrl = dictionary["profile_banner_url"] as? String
        
        tagline = dictionary["description"] as? String
        
        followerCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        tweetCount = dictionary["statuses_count"] as? Int
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }

    
    class var currentUser: User? {

        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    do {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                        _currentUser = User(dictionary: dictionary)
                    } catch {
                        print ("error in class var currentUser GET with JSONObjectWithData")
                    }
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: .PrettyPrinted)
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch {
                    print ("error in class var currentUser SET with JSONObjectWithData")
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
}
