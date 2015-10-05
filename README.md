## CodePath Week 3: Twitter

This is a basic Twitter client that uses the [Twitter API](https://apps.twitter.com/) to read and compose tweets. It's also the assignment for Week 3 of the [CodePath](http://www.codepath.com) iOS for Engineers class for Fall 2015, built with [Xcode 7.0](https://developer.apple.com/xcode/download/) and Swift. 

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

- [X] I got really annoyed at how links couldn't actually click through. So made that happen in the detail view, along with coloring the link in blue. (The coloring part was harder than it sounds.)


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
