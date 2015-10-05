## CodePath Week 3: Twitter

This is a basic Twitter client that uses the [Twitter API](https://apps.twitter.com/) to read and compose tweets. It's also the assignment for Week 3 of the [CodePath](http://www.codepath.com) iOS for Engineers class for Fall 2015, built with [Xcode 7.0](https://developer.apple.com/xcode/download/) and Swift. 

Last week, the screen from my 2012 laptop broke and had to be replaced. So this week's episode was viewed on a new screen with over 4 million functional pixels ("Retina Display"). More hours staring at a screen! For this homework, I only prioritized Twitter features related to reading tweets. Because relatively few people actively interact with tweets in real life (and of course they can use the official Twitter app for that).

Time spent: 16 hours

#### Required Features

- [X] User can sign in using OAuth login flow
- [X] User can view last 20 tweets from their home timeline
- [X] The current signed in user will be persisted across restarts
- [X] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [X] User can pull to refresh
- [X] User can compose a new tweet by tapping on a compose button.
- [X] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

#### Optional Features

- [X] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [X] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

#### Bonus Features

- [X] I got really annoyed at how links couldn't actually click through to read content. So made that happen in the detail view, along with coloring those links in blue. (The coloring part was harder than it sounds.)
- [X] Twitter can load up to 200 tweets at a time (not just 20). For ease of infinite scrolling, the demo is configured to load 25 tweets at a time.


### Walkthrough

![Video Walkthrough](TwitterAnimated.gif)

Credits
---------
* [Twitter API](https://apps.twitter.com/)
* CodePath videos on [Twitter OAuth](https://vimeo.com/107295686) and [User Persistence](https://vimeo.com/107319225)
* CodePath [Pull to Refresh guide](https://guides.codepath.com/ios/Table-View-Guide#implementing-pull-to-refresh-with-uirefreshcontrol)
* [Implementation from jerrysu for reference](https://github.com/jerrysu/CodePath-Twitter)
* [Implementation from toph808 for reference](https://github.com/toph808/twitter)
* [Yelp implementation from xke for reference](https://github.com/xke/Yelp)
* [Rotten Tomatoes implementation from xke for reference](https://github.com/xke/Rotten-Tomatoes/)
* [LiceCap for making the animated gif](http://www.cockos.com/licecap/)
