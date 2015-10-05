//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by Xian on 10/4/15.
//  Copyright © 2015 swifterlabs. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var tweet: Tweet!
    
    let tapRecognizer = UITapGestureRecognizer()
    var tweetURL: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let usernameDisplay = "@\((tweet.user?.screenname)!)"
        
        self.title = usernameDisplay
        
        nameLabel.text = tweet.user?.name
        usernameLabel.text = usernameDisplay
        timestampLabel.text = tweet.createdAtString!
        tweetTextLabel.text = tweet.text
        userImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!))
        
        // rounded edge!
        userImageView.layer.cornerRadius = 9.0
        
        // find first URL in the text label
        tweetURL = findURLFromText(tweet.text!)
        if tweetURL != nil {
            
            // allow click through to link if there's a URL
            // http://www.avocarrot.com/blog/implement-gesture-recognizers-swift/
            
            tapRecognizer.addTarget(self, action: "openURL")
            tweetTextLabel.userInteractionEnabled = true
            tweetTextLabel.addGestureRecognizer(tapRecognizer)
            
            // make the URL part of the label blue!
            tweetTextLabel.attributedText = colorURLInText(tweetTextLabel.text!, urlString: tweetURL!.absoluteString)
            
        }
    }

    
    func findURLFromText(text: String) -> NSURL? {
        do {
            let types: NSTextCheckingType = .Link
            let detector = try NSDataDetector(types: types.rawValue)
            let matches = detector.matchesInString(text, options: .ReportCompletion, range: NSMakeRange(0, text.characters.count))
            if matches.count > 0 {
                return matches[0].URL!
            }
        } catch {
            // none found or some other issue
            print ("error in findURLFromText")
        }
        // default case; none found
        return nil
    }
    
    func openURL() {
        print("Opening URL: \(tweetURL!)")
        UIApplication.sharedApplication().openURL(tweetURL!)
    }
    

    
    func colorURLInText(mainString : String, urlString: String) -> NSAttributedString {
        
        let swiftRange = mainString.rangeOfString(urlString) // range conversion, yuck
        let nsRange = mainString.nsRangeFromRange(swiftRange!) // extension method at bottom of file
        
        let attributedString = NSMutableAttributedString(string: mainString)

        // add the tint color!
        attributedString.addAttribute(NSForegroundColorAttributeName, value: self.view.tintColor, range: nsRange)
        
        return attributedString
        
    }
    
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

// via https://github.com/intelliot/Memorizer/blob/master/Memorizer/ViewController.swift

extension String {
    func rangeFromNSRange(nsRange: NSRange) -> Range<String.Index>? {
        let startUtf16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let endUtf16 = startUtf16.advancedBy(nsRange.length, limit: utf16.endIndex)
        if let startIndex = String.Index(startUtf16, within: self),
            let endIndex = String.Index(endUtf16, within: self) {
                return startIndex ..< endIndex
        }
        return nil
    }
    
    func nsRangeFromRange(range: Range<String.Index>) -> NSRange {
        let prefix = substringToIndex(range.startIndex)
        let substring = substringWithRange(range)
        return NSRange(location: prefix.utf16.count, length: substring.utf16.count)
    }
}
