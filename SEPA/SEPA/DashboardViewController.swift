//
//  DashboardViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 28/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifier = "tableViewCell"
    
    var dummyTitles = ["My Weather", "My News", "My Photos", "My Location History", "My Calculator", "My Converter", "My Settings"]
    
    var dummySummaries = ["Sunny Today!", "Last updated: Just Now", "3 New Photos Today", "Last updated: Just Now", "Last Result: 5", "Last Result: 28mph", "Adjust Sepa for your needs"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let id = segue.identifier {
            switch(id) {
            case "showWeather" : break
            case "showNews": break
            default: break
            }
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: DashboardTableViewCell = (tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as? DashboardTableViewCell)!
        
        cell.title.text = dummyTitles[indexPath.row]
        cell.summary.text = dummySummaries[indexPath.row]
        cell.dashboardIcon.image = UIImage(named: "fog")
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! DashboardTableViewCell
    
        switch(cell.title.text!){
            case "My Weather" : performSegueWithIdentifier("showWeather", sender: indexPath)
            case "My News" : performSegueWithIdentifier("showNews", sender: indexPath)
            case "My Photos" : performSegueWithIdentifier("showPhotos", sender: indexPath)
            case "My Location History" : performSegueWithIdentifier("showLocationHistory", sender: indexPath)
            case "My Calculator" : performSegueWithIdentifier("showCalculator", sender: indexPath)
            case "My Converter" : performSegueWithIdentifier("showConverter", sender: indexPath)
            case "My Settings" : performSegueWithIdentifier("showSettings", sender: indexPath)
            default : break
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyTitles.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Dashboard Apps"
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
