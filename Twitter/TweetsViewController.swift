//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Xian on 10/3/15.
//  Copyright © 2015 swifterlabs. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    var tweets: [Tweet]?
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    let TweetsPerLoad = 25
    
    // create instance of our custom transition manager
    let transitionManager = MenuTransitionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("in TweetsViewController viewDidLoad")

        
        // Do any additional setup after loading the view.
        
        // colorize nav bar
        // http://www.ralfebert.de/snippets/ios/swift-uicolor-picker/ on rgb(136, 201, 249)
        /*
        let twitterColor = UIColor(hue: 0.5694, saturation: 0.45, brightness: 0.97, alpha: 1.0)
        self.navigationController!.navigationBar.barTintColor = twitterColor
        */
        
        // cleaner in default color
        self.navigationController!.navigationBar.barTintColor = UIColor.whiteColor()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension // based on autolayout
        tableView.estimatedRowHeight = 120 // for scroll bar
        
        
        // refresh control
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "loadTweets", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        
        // infinite scrolling via pod

        tableView.addInfiniteScrollWithHandler { [weak self] (scrollView) -> Void in
            let scrollView = scrollView as! UITableView
            
            self?.loadTweets() {
                scrollView.finishInfiniteScroll()
            }
        }
        
        // first tweet load
        loadTweets()
        
        // menu transition animation (see MenuViewController)
        
        self.transitionManager.sourceViewController = self


    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //print("in TweetsViewController viewDidAppear")
        
        // this function gets called after Compose is completed
        // so we can take the opportunity to refresh tweets!
        
        if (TwitterClient.sharedInstance.postedTweet == true) {
            loadTweets()
            TwitterClient.sharedInstance.postedTweet = false
        }
        
    }

    func loadTweets() {
        loadTweets(nil)
    }
    
    func loadTweets(infiniteHandler: ((Void) -> Void)?) {
        
        // params reference: https://dev.twitter.com/rest/reference/get/statuses/home_timeline

        var params = ["count": TweetsPerLoad]
        
        // for an infinite scroll request, check max tweet for self.tweets
        
        if (infiniteHandler != nil && tweets != nil && tweets!.count > 0) {
            let max_tweet = tweets![tweets!.count-1].idStr!
            // minus 1, to avoid a repeat tweet (older tweets < newer tweets)
            params["max_id"] = Int(max_tweet)! - 1
        }
        
        //print("loadTweets params \(params)")
        
        TwitterClient.sharedInstance.homeTimelineWithParams(params, completion: { (tweets, error) -> () in
            dispatch_async(dispatch_get_main_queue(), {
                if error != nil {
                    print("loadTweets error: \(error)")
                    return
                }
                print("loadTweets adding tweet count \(tweets!.count)")

                if (self.tweets != nil && infiniteHandler != nil) {
                    self.tweets = self.tweets! + tweets!
                } else {
                    self.tweets = tweets!
                }
                
                print("loadTweets done with tweet count \(self.tweets!.count)")
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()

                if (infiniteHandler != nil) {
                    infiniteHandler?() // handle back, if on infinite load
                } else {
                    // scroll to top, because it's a refresh
                    self.scrollToTop()


                }
                
                
                
            })
        })
    }
    
    func scrollToTop() {
        let top = NSIndexPath(forRow: Foundation.NSNotFound, inSection: 0);
        self.tableView.scrollToRowAtIndexPath(top, atScrollPosition: UITableViewScrollPosition.Top, animated: true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // table view
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets?[indexPath.row]
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    // MARK: - Navigation
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    /*
    tried a segue way to show current user profile, but opted for presenting it from menu instead.
    
    func onYourProfilePressed() {
        self.performSegueWithIdentifier("yourProfile", sender: User.currentUser)
    }
    */
    
    @IBAction func onProfileImagePressed(sender: UIButton) {
        
        let cell = sender.superview?.superview as! TweetCell
        let user = cell.tweet.user!
        self.performSegueWithIdentifier("fromUserImageToProfile", sender: user)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
       // print ("TweetsViewController segue with identifier: \(segue.identifier!)")
        if (segue.identifier == "fromTweetCellToTweetDetails") {
            
            //print("prepareForSegue to TweetDetailsViewController")
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            
            let tweetDetailsViewController = segue.destinationViewController as! TweetDetailsViewController
            tweetDetailsViewController.tweet = tweets![indexPath.row]
            
        }
        
        if (segue.identifier == "fromUserImageToProfile") {
            let vc = segue.destinationViewController as! ProfileViewController
            vc.user = sender as! User
        }

        // show menu
        if (segue.identifier == "presentMenu") {
            // set transition delegate for our menu view controller
            let menu = segue.destinationViewController as! MenuViewController
            menu.transitioningDelegate = self.transitionManager
            self.transitionManager.menuViewController = menu
        }

        
    }
    
   // "To add an unwind segue that will only be triggered programmatically, control+drag from the scene's view controller icon to its exit icon as shown in Figure 2. Choose an unwind action for the new segue from the popup menu. You must also give the segue an identifier so that it can be referenced by your code."

    // for menu
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        // self.dismissViewControllerAnimated(true, completion: nil)
        // somehow commenting out above line makes it work as expected in simulator
    }

}