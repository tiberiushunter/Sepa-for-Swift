//
//  DashboardViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 28/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifier = "tableViewCell"
    
    var lastCalc = 0.00
    
    var appTitles = ["My Weather", "My News", "My Plants", "My Location History", "My Calculator", "My Converter", "My Settings"]
    
    var appSummaries = ["Sunny Today!", "Last updated: Just Now", "Could do with some watering", "Last updated: Just Now", "Last Result: 5", "Last Result: 28mph", "Adjust Sepa for your needs"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        lastCalc = (NSUserDefaults.standardUserDefaults().doubleForKey("lastCalc"))
        tableView.reloadData()
    }

    @IBAction func editButtonAction(sender: AnyObject) {
        if(editButton.title == "Edit"){
            editButton.title = "Done"
        } else{
            editButton.title = "Edit"
        }
        tableView.editing = !tableView.editing
       
    }
    
    func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true}
    
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        var itemToMove = appTitles[fromIndexPath.row]
        appTitles.removeAtIndex(fromIndexPath.row)
        appTitles.insert(itemToMove, atIndex: toIndexPath.row)
        
        itemToMove = appSummaries[fromIndexPath.row]
        appSummaries.removeAtIndex(fromIndexPath.row)
        appSummaries.insert(itemToMove, atIndex: toIndexPath.row)
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
        
        cell.title.text = appTitles[indexPath.row]
        cell.summary.text = appSummaries[indexPath.row]
        switch (cell.title.text!){
            case "My Weather": cell.dashboardIcon.image = UIImage(named: "fog")
            case "My News": cell.dashboardIcon.image = UIImage(named: "dashboard-news")
            case "My Plants": cell.dashboardIcon.image = UIImage(named: "dashboard-plants")
            case "My Location History": cell.dashboardIcon.image = UIImage(named: "dashboard-locationhistory")
            case "My Calculator":
                cell.dashboardIcon.image = UIImage(named: "dashboard-calculator")
                cell.summary.text = "Last Result = \(Double(lastCalc))"
            case "My Converter": cell.dashboardIcon.image = UIImage(named: "dashboard-converter")
            case "My Settings": cell.dashboardIcon.image = UIImage(named: "dashboard-settings")
        default: cell.dashboardIcon.image = UIImage(named: "dashboard-calculator")
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! DashboardTableViewCell
    
        switch(cell.title.text!){
            case "My Weather" : performSegueWithIdentifier("showWeather", sender: indexPath)
            case "My News" : performSegueWithIdentifier("showNews", sender: indexPath)
            case "My Plants" : performSegueWithIdentifier("showPlants", sender: indexPath)
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
        return appTitles.count
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
