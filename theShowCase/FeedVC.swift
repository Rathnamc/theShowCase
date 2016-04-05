//
//  FeedVC.swift
//  theShowCase
//
//  Created by Christopher Rathnam on 3/21/16.
//  Copyright © 2016 Christopher Rathnam. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    static var imageCache = NSCache()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 358
        
        //Anytime a value is changed update instantaneously
        //Main Snapshot
        DataService.ds.REF_POSTS.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            
            self.posts = []
            //Parsing Data - Grabbing from snapshot
            // This is each subSnapshot
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                //cycle through each snapshot
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    
                    //convert into a dictionary
                    if let postDict = snap.value as? Dictionary <String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, dictionary: postDict)
                        self.posts.append(post)
                    }
                }
                
            }
            
            self.tableView.reloadData()
        })
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
        let post = posts[indexPath.row]
    
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            //cell.request?.cancel()
            var img: UIImage?
            
            //if image URL is not empty grab image from cache
            if let url = post.imageUrl {
                img = FeedVC.imageCache.objectForKey(url) as? UIImage
            }
            
            cell.configureCell(post, img: img)
            
            return cell
        } else {
           return PostCell()
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let post = posts[indexPath.row]
        
        if post.imageUrl == nil {
            return 150
            
        } else {
            return tableView.estimatedRowHeight
        }
    }
    
}
