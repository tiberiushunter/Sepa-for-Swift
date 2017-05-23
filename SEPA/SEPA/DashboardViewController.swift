//
//  DashboardViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 23/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifier = "tableViewCell"
    var dummyObjects = ["Weather", "News", "Calendar", "Calculator", "Photos", "Settings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let id = segue.identifier{
            if (id == "WeatherSegue"){
                let newVc = segue.destinationViewController as! WeatherViewController
                newVc.passedString = "Hello Weather Controller"
            } else if (id == "NewsSegue"){
                let newVc = segue.destinationViewController as! NewsViewController
                newVc.passedString = "Hello News Controller"
            } else if (id == "CalendarSegue"){
                let newVc = segue.destinationViewController as! CalendarViewController
                newVc.passedString = "Hello Calendar Controller"
            } else if (id == "CalculatorSegue"){
                let newVc = segue.destinationViewController as! CalculatorViewController
                newVc.passedString = "Hello Calculator Controller"
            } else if (id == "PhotosSegue"){
                let newVc = segue.destinationViewController as! PhotoViewController
                newVc.passedString = "Hello Photo Controller"
            } else if (id == "SettingsSegue"){
                let newVc = segue.destinationViewController as! SettingsViewController
                newVc.passedString = "Hello Settings Controller"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = dummyObjects[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didDeSelectRowsAtIndexPath indexPath: NSIndexPath){
        print (indexPath)
        
        /*Add cases here to move to different segues
        switch indexPath.row{
        case 0: self.performSegueWithIdentifier("Weather", sender: self);
        break;
        case 1: self.performSegueWithIdentifier("News", sender: self);
        break;
        case 2: self.performSegueWithIdentifier("Calendar", sender: self);
        break;
        case 3: self.performSegueWithIdentifier("Calculator", sender: self);
        break;
        case 4: self.performSegueWithIdentifier("Photos", sender: self);
        break;
        case 5: self.performSegueWithIdentifier("Settings", sender: self);
        break;
        default:
            break
        }
 */
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyObjects.count
    }

}
