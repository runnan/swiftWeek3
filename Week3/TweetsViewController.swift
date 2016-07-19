//
//  TweetsViewController.swift
//  Week3
//
//  Created by Khang Le on 7/17/16.
//  Copyright © 2016 Khang Le. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    @IBAction func onLogout(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    var tweets = [Tweet]()
    @IBOutlet weak var tweetTableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initialize a UIRefreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        // Tell the refreshControl to stop spinning
        self.tweetTableView.delegate = self
        self.tweetTableView.dataSource = self
        self.tweetTableView.estimatedRowHeight = 100
        self.tweetTableView.rowHeight = UITableViewAutomaticDimension
        self.tweetTableView.insertSubview(refreshControl, atIndex: 0)
        
        refreshControlAction(refreshControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) in
            self.tweets = tweets
            self.tweetTableView.reloadData()
            refreshControl.endRefreshing()
        }) { (error:NSError) in
            print(error.localizedDescription)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let navigationVC = segue.destinationViewController as! UINavigationController
        
        let newTweetVC = navigationVC.topViewController as! NewTweetViewController
        newTweetVC.user = User.currentUser
        newTweetVC.delegate = self
    }
 


}

extension TweetsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tweetTableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}

extension TweetsViewController: NewTweetViewControllerDelegate{
    func newTweetViewControllerDelegate (newTweetViewController:NewTweetViewController, didAddNewTweet result : Bool){
        refreshControlAction(refreshControl)
    }
}
