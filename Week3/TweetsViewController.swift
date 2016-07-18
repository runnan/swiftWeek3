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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) in
            self.tweets = tweets
            self.tweetTableView.delegate = self
            self.tweetTableView.dataSource = self
            self.tweetTableView.estimatedRowHeight = 100
            self.tweetTableView.rowHeight = UITableViewAutomaticDimension
            self.tweetTableView.reloadData()
            
        }) { (error:NSError) in
                print(error.localizedDescription)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
