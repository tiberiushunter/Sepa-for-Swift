//
//  Weather48HourViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 19/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit
import MapKit

class Weather48HourViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var coords = CLLocationCoordinate2D(latitude: 53.4846, longitude: -2.2708)
    
    var weatherHourly: Array<WeatherModel> = []
    
    @IBOutlet weak var tableView: UITableView!
    let reuseIdentifier = "tableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getLocation()
        getWeather { jsonString in
            if let jsonDictionary = Utilities().convertStringToDictionary(jsonString as String){
                if let weatherData = jsonDictionary["hourly"]!["data"]! as? [Dictionary<String, AnyObject>]{
                    print(weatherData)
                    for i in 0 ..< weatherData.count {
                        let weatherHourData = WeatherModel(
                            time: Double(weatherData[i]["time"]! as! NSNumber),
                            icon: String(weatherData[i]["icon"]!),
                            temperature: Double(weatherData[i]["temperature"]! as! NSNumber),
                            apparentTemperature: Double(weatherData[i]["apparentTemperature"]! as! NSNumber),
                            summary: String(weatherData[i]["summary"]!),
                            windDirection: Double(weatherData[i]["windBearing"]! as! NSNumber),
                            windSpeed: Double(weatherData[i]["windSpeed"]! as! NSNumber),
                            chanceOfRain: Double(weatherData[i]["precipProbability"]! as! NSNumber),
                            rainIntensity: Double(weatherData[i]["precipIntensity"]! as! NSNumber)
                        )
                        self.weatherHourly.append(weatherHourData)
                    }
                    dispatch_async(dispatch_get_main_queue()){
                        self.tableView.reloadData()
                    }
                }
            }
        }

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
            if (id == "showWeather48HourDetail"){
                let newVc = segue.destinationViewController as! Weather48HourDetailViewController
                if let indexPath = tableView.indexPathForSelectedRow {
                    let cell = tableView.cellForRowAtIndexPath(indexPath) as! Weather48HourTableCell
                   
                    newVc.timestamp = cell.timestamp
                    newVc.summary = cell.summary
                    newVc.currentTemperature = cell.currentTemperature
                    newVc.feelLikeTemperaure = cell.feelLikeTemperaure
                    newVc.windDirection = cell.windDirection
                    newVc.windSpeed = cell.windSpeed
                    newVc.chanceOfRain = cell.chanceOfRain
                    newVc.rainIntensity = cell.rainIntensity
                    newVc.imageIcon = cell.imageIcon
                }
                
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: Weather48HourTableCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! Weather48HourTableCell
        
        cell.timestamp = Utilities().getDateTimeFromTimestamp(weatherHourly[indexPath.row].getTime())
        cell.summary = weatherHourly[indexPath.row].getSummary()
        cell.currentTemperature = weatherHourly[indexPath.row].getTemperature()
        cell.feelLikeTemperaure = weatherHourly[indexPath.row].getApparentTemperature()
        cell.windDirection = weatherHourly[indexPath.row].getWindDirection()
        cell.windSpeed = weatherHourly[indexPath.row].getWindSpeed()
        cell.chanceOfRain = weatherHourly[indexPath.row].getChanceOfRain()
        cell.rainIntensity = weatherHourly[indexPath.row].getRainIntensity()
        //cell.nearestStormDistance = weatherHourly[indexPath.row].getNearestStormDistance()
       // cell.nearestStormDirection = weatherHourly[indexPath.row].getNearestStormDirection()
        //cell.imageIcon = weatherHourly[indexPath.row]

        cell.lblTemperature.text = String(format: "%.2f", Utilities().convertToCelsius(weatherHourly[indexPath.row].getTemperature())) + "°C"
        cell.lblSummary.text = weatherHourly[indexPath.row].getSummary()
        cell.lblTime.text = Utilities().getDateTimeFromTimestamp(weatherHourly[indexPath.row].getTime())
        
        switch(weatherHourly[indexPath.row].getIcon()){
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
        cell.weatherIcon.image = UIImage(named: cell.imageIcon.rawValue)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherHourly.count
    }
}


