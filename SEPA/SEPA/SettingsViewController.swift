//
//  SettingsViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 19/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    /*
 
 
 
 
 //
 
 //    let bbcNewsSource = NSUserDefaults.standardUserDefaults().objectForKey("newsSource_bbcNews") as! Bool
 
 //    if(bbcNewsSource == true){
 //    newsSources.append("BBC News")
 //   }
 
 NSUserDefaults.standardUserDefaults().setObject(Bool(true), forKey:"newsSource_bbc-news")
 
 
 
 */
    
    let settingSectionList = ["My News Sources"]
    
    var newsSources: Array<NewsSourceModel> = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var passedString = "blank"
    let reuseIdentifier = "tableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
        tableView.dataSource = self
        tableView.delegate = self
        
        self.getNewsSources() { jsonString in
            if let jsonDictionary = Utilities().convertStringToDictionary(jsonString as String){
                if let sources = jsonDictionary["sources"] as? [Dictionary<String, AnyObject>]{
                    for i in 0 ..< sources.count {
                        let newsSource = NewsSourceModel(
                            id: String(sources[i]["id"]!),
                            name: String(sources[i]["name"]!)
                        )
                            self.newsSources.append(newsSource)
                        //Below checks to see if the news source currently has a key
                        //if it doesn't then add the key with the default value of false
                        if ((NSUserDefaults.standardUserDefaults().objectForKey("newsSource_" + newsSource.getId())) == nil){
                            NSUserDefaults.standardUserDefaults().setObject(Bool(false), forKey:"newsSource_" + newsSource.getId())
                        }
                    }
                    dispatch_async(dispatch_get_main_queue()){
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func getNewsSources(completion: (NSString) -> ()) {
        let urlPath = NewsSourcesURL().getFullURL()
        let url: NSURL = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        
        let session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let jsonString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            completion(jsonString!)
            
        })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SettingsTableViewCell = (tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as? SettingsTableViewCell)!
        
        cell.lblSetting.text = newsSources[indexPath.row].getName()
        cell.setting = newsSources[indexPath.row].getId()
        cell.newsLogo.image = UIImage(named: newsSources[indexPath.row].getId())
        
        cell.checkSwitchStatus()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return settingSectionList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsSources.count
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
