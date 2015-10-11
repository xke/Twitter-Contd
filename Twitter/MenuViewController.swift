//
//  MenuViewController.swift
//  Twitter
//
//  Created by Xian on 10/10/15.
//  Copyright © 2015 swifterlabs. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var tweetsViewController: TweetsViewController!
    var enterPanGesture = UIPanGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tweetsViewController = storyboard?.instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
        
        self.view.tintColor = UIColor.whiteColor()
    }

    @IBAction func onYourProfile(sender: UIButton) {

        let profileViewController = storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        profileViewController.user = User.currentUser!


        enterPanGesture.addTarget(profileViewController, action:"dismissYourProfile")
        profileViewController.view.addGestureRecognizer(enterPanGesture)
        profileViewController.unhideSwipeToCloseMessage()
        self.presentViewController(profileViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func onYourTweets(sender: UIButton) {
        /*
        let vc = storyboard?.instantiateViewControllerWithIdentifier("TweetsViewAndNavigationController")
        self.presentViewController(vc!, animated: true, completion: nil)

        self.showViewController(tweetsViewController, sender: self)

        */
        
        // simple way, when menu only appears from tweets view
        self.dismissViewControllerAnimated(true, completion: nil)

    }

    @IBAction func onLogout(sender: UIButton) {
        User.currentUser?.logout()
    }
    
    @IBAction func onCloseMenu(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //if segue.identifier == "fromUserImageToProfile" {
            let vc = segue.destinationViewController as! ProfileViewController
            vc.user = User.currentUser
        //}
        
        
    }
*/

}
