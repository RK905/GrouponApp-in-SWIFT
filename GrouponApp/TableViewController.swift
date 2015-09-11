//
//  TableViewController.swift
//  GrouponApp
//
//  Created by Rayen Kamta on 8/14/15.
//  Copyright (c) 2015 Rayen Kamta. All rights reserved.
//

import UIKit
import Foundation

class TableViewController: UITableViewController {
    
    let theUrlString :String = "http://api.groupon.com/v2/deals?client_id=8d1f63c7a85319c3d7671b108964fbfc0ea72d86"
    
    var dealsArray : NSMutableArray?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let url = NSURL(string: theUrlString)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, response, error) in
            
            let dealsDictionary: AnyObject? =  NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
            
            let theArray :NSArray = dealsDictionary?.objectForKey("deals") as! NSArray
            
            self.dealsArray = NSMutableArray()
            
            for dealDictionary in theArray{
                
                var theDeal = Deals()
                theDeal.title = dealDictionary.objectForKey("shortAnnouncementTitle") as? String
             
                self.dealsArray?.addObject(theDeal)
                
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                print("Hello")

            })
            
            self.tableView.reloadData()
            
        })
        
        
        task.resume()
        
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        var count: Int = 0
        if self.dealsArray != nil {
            count = self.dealsArray!.count
        }
        
        return count
    }

    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        let theDeal: AnyObject? = self.dealsArray?.objectAtIndex(indexPath.row)
        
        
        

        // Configure the cell...
        cell.textLabel?.text = theDeal?.title

        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
