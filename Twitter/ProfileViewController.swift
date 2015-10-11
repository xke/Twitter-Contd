//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Xian on 10/10/15.
//  Copyright © 2015 swifterlabs. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    
    // set to be hidden by default
    @IBOutlet weak var swipeToCloseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        nameLabel.text = user.name
        usernameLabel.text = "@\(user.screenname!)"
        
        
        if let profileBannerUrl = user.profileBannerUrl {
            bannerImageView.setImageWithURL(NSURL(string: profileBannerUrl))
        }
        userImageView.setImageWithURL(NSURL(string: user.profileImageUrl!))
        userImageView.layer.cornerRadius = 9.0
        self.view.bringSubviewToFront(userImageView)
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        
        followingCountLabel.text = formatter.stringFromNumber(user.followingCount!)
        followerCountLabel.text = formatter.stringFromNumber(user.followerCount!)
        tweetCountLabel.text = formatter.stringFromNumber(user.tweetCount!)
        
        swipeToCloseLabel.hidden = true
        
        
    }
    
    // only unhide when showing current user profile from Menu
    
    func unhideSwipeToCloseMessage() {
        swipeToCloseLabel.hidden = false
    }
    
    // only set in menu for now... 
    
    func dismissYourProfile() {
        //print("Dismissing Current Profile")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
