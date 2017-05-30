//
//  Weather7DayViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 19/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit
import MapKit

class Weather7DayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var coords = CLLocationCoordinate2D(latitude: 53.4846, longitude: -2.2708)
    
    var jsonString = ""
    

    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifier = "tableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocation()
        getWeather { jsonString in
            self.jsonString = jsonString as String
            
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLocation(){
        if let loc = locationManager.location?.coordinate{
            coords = loc
        }
    }
    
    func getWeather(completion: (NSString) -> ()) {
        let urlPath = WeatherURL(lat: String(coords.latitude), long: String(coords.longitude)).getFullURL()
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let id = segue.identifier{
            if (id == "showWeather7DayDetail"){
                let newVc = segue.destinationViewController as! Weather7DayDetailViewController
                if let indexPath = tableView.indexPathForSelectedRow {
                    let cell = tableView.cellForRowAtIndexPath(indexPath) as! Weather7DayTableCell
                    
                    newVc.timestamp = cell.timestamp
                    newVc.summary = cell.summary
                    newVc.temperatureMinimum = cell.temperatureMinimum
                    newVc.temperatureMaximum = cell.temperatureMaximum
                    newVc.windDirection = cell.windDirection
                    newVc.windSpeed = cell.windSpeed
                    newVc.chanceOfRain = cell.chanceOfRain
                    newVc.rainIntensity = cell.rainIntensity
                    newVc.nearestStormDistance = cell.nearestStormDistance
                    newVc.nearestStormDirection = cell.nearestStormDirection
                    newVc.imageIcon = cell.imageIcon
                }
                
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: Weather7DayTableCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! Weather7DayTableCell
        
        if let jsonDictionary = Utilities().convertStringToDictionary(jsonString){
            if let daily = jsonDictionary["daily"] as? Dictionary<String, AnyObject>{
                if let data = daily["data"]![indexPath.row] as?
                    Dictionary<String, AnyObject>{
                    if let tempMin = data["temperatureMin"] as? Double{
                        cell.temperatureMinimum = tempMin
                    }
                    if let tempMax = data["temperatureMax"] as? Double{
                        cell.temperatureMaximum = tempMax
                    }
                    if let sum = data["summary"] as? String {
                        cell.summary = sum
                        cell.lblSummary.text = sum
                    }
                    if let windDir = data["windBearing"] as? Double {
                        cell.windDirection = windDir
                    }
                    if let windSpe = data["windSpeed"] as? Double {
                        cell.windSpeed = windSpe
                    }
                    if let chanceOfRain = data["precipProbability"] as? Double {
                        cell.chanceOfRain = chanceOfRain
                    }
                    if let rainInt = data["precipIntensity"] as? Double {
                        cell.rainIntensity = rainInt
                    }
                    if let nearStormDist = data["nearestStormDistance"] as? Double {
                        cell.nearestStormDistance = nearStormDist
                    }
                    if let nearStormDir = data["nearestStormBearing"] as? Double {
                        cell.nearestStormDirection = nearStormDir
                    }
                    if let time = data["time"] as? Double {
                        cell.lblTime.text = Utilities().getDateFromTimestamp(time)
                        cell.timestamp = Utilities().getDateFromTimestamp(time)
                    }
                    if let imageIcon = data["icon"] as? String {
                        switch(imageIcon){
                        case "clear-day":
                            cell.imageIcon = WeatherIcon.clearDay
                        case "clear-night":
                            cell.imageIcon = WeatherIcon.clearNight
                        case "rain":
                            cell.imageIcon = WeatherIcon.rain
                        case "snow":
                            cell.imageIcon = WeatherIcon.snow
                        case "sleet":
                            cell.imageIcon = WeatherIcon.snow
                        case "wind":
                            cell.imageIcon = WeatherIcon.wind
                        case "fog":
                            cell.imageIcon = WeatherIcon.fog
                        case "cloudy":
                            cell.imageIcon = WeatherIcon.cloudy
                        case "partly-cloudy-day":
                            cell.imageIcon = WeatherIcon.partlyCloudyDay
                        case "partly-cloudy-night":
                            cell.imageIcon = WeatherIcon.partlyCloudyNight
                        case "hail":
                            cell.imageIcon = WeatherIcon.rain
                        case "thunderstorm":
                            cell.imageIcon = WeatherIcon.thunderstorm
                        case "tornado":
                            cell.imageIcon = WeatherIcon.tornado
                            
                        default:
                            cell.imageIcon = WeatherIcon.nothing
                        }
                        let averageTemp = cell.temperatureMaximum - (cell.temperatureMaximum - cell.temperatureMinimum)
                        cell.lblTemperature.text = String(format: "%.2f", Utilities().convertToCelsius(averageTemp)) + "°C"
                        cell.weatherIcon.image = UIImage(named: cell.imageIcon.rawValue)
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
}


