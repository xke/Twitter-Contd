//
//  ComposeTweetViewController.swift
//  Twitter
//
//  Created by Xian on 10/4/15.
//  Copyright © 2015 swifterlabs. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {
    
    @IBOutlet weak var newTweetTextView: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        usernameLabel.text = "as @\((User.currentUser!.screenname)!)"
        
        newTweetTextView.layer.cornerRadius = 9.6
        newTweetTextView.layer.borderWidth = 1
        newTweetTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
    
        newTweetTextView.becomeFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }


    @IBAction func postTweetAction(sender: UIButton) {
        let params: NSDictionary = [
            "status": newTweetTextView.text
        ]
        
        TwitterClient.sharedInstance.postStatusUpdateWithParams(params, completion: { (tweet, error) -> () in
            if error != nil {
                print("error posting status: \(error)")
                return
            }
            
            print ("Tweet posted successfully! Yay!")
            TwitterClient.sharedInstance.postedTweet = true
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        
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
