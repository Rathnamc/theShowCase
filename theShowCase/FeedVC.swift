//
//  FeedVC.swift
//  theShowCase
//
//  Created by Christopher Rathnam on 3/21/16.
//  Copyright © 2016 Christopher Rathnam. All rights reserved.
//

import UIKit

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        //Anytime a value is changed update instantaneously
        DataService.ds.REF_POSTS.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            self.tableView.reloadData()
        })
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
        return tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostCell
        
    }
    
    

}
