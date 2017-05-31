//
//  PlantsViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 19/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//
import Foundation
import UIKit

class PlantsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    var passedString = "blank"
    
    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifier = "tableViewCell"
    
    var plantData: Array<PlantsModel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        tableView.dataSource = self
        tableView.delegate = self
        
        self.getPlantData() { jsonString in
            //print(jsonString)
            
            let jsonStr = jsonString as String
            let json: AnyObject? = jsonStr.parseJSONString

            for i in 0 ..< json!.count {
                let data = PlantsModel(
                    timestamp: json![i]["Timestamp"] as! String,
                    ambientLight: json![i]["AmbientLight"] as! String,
                    externalLight: json![i]["ExternalLight"] as! String,
                    soilMoisture: json![i]["SoilMoisture"] as! String,
                    hardwareTemperature: json![i]["HardwareTemperature"] as! String,
                    externalTemperature: json![i]["ExternalTemperature"] as! String,
                    ambientHumidity: json![i]["AmbientHumidity"] as! String,
                    ambientTemperature: json![i]["AmbientTemperature"] as! String
                )
                self.plantData.append(data)
                print(self.plantData[i].getTimestamp())
            }
            dispatch_async(dispatch_get_main_queue()){
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func getPlantData(completion: (NSString) -> ()) {
        let urlPath = PlantApi().getFullURL()
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: PlantsTableViewCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PlantsTableViewCell

        
        cell.timestamp.text = "Timestamp: " + plantData[indexPath.row].getTimestamp()
        cell.ambientLight.text = "Ambient Light: " + plantData[indexPath.row].getAmbientLight() + "%"
        cell.externalLight.text = "External Light: " + plantData[indexPath.row].getExternalLight() + "%"
        cell.soilMoisture.text = "Soil Moisture: " + plantData[indexPath.row].getSoilMoisture() + "%"
        cell.hardwareTemperature.text = "Hardware Temperature: " + plantData[indexPath.row].getHardwareTemperature() + "°C"
        cell.externalTemperature.text = "External Temperature: " + plantData[indexPath.row].getExternalTemperature() + "°C"
        cell.ambientHumidity.text = "Ambient Humidity: " + plantData[indexPath.row].getAmbientHumidity() + "%"
        cell.ambientTemperature.text = "Ambient Temperature: " + plantData[indexPath.row].getAmbientTemperature() + "°C"
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Plant"
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantData.count
        
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
