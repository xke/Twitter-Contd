//
//  TweetCell.swift
//  Twitter
//
//  Created by Xian on 10/3/15.
//  Copyright © 2015 swifterlabs. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.user?.name
            usernameLabel.text = "@\((tweet.user?.screenname)!)"
            timestampLabel.text = Tweet.formatTimeElapsed(tweet.createdAt!)
            tweetTextLabel.text = tweet.text
            userImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!))
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // rounded edge!
        userImageView.layer.cornerRadius = 9.0
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
