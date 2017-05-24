//
//  WeatherModel.swift
//  SEPA
//
//  Created by Welek Samuel on 24/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import Foundation
import MapKit

class WeatherModel: NSObject, CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    var coords = CLLocationCoordinate2D(latitude: 53.4846, longitude: -2.2708)
    
    var currentTemp = 0.00
    
    var wVCId = WeatherViewControllerId.nothing
    
    init(Id: WeatherViewControllerId){
        wVCId = Id
    }
    
    
    
    func getCurrentTemp() -> String{
        return String(self.currentTemp)
    }
    
    func getLocation() -> CLLocationCoordinate2D{
        if let loc = locationManager.location?.coordinate{
            return loc
        }
        return coords
        
    }
    
    func getWeatherData() -> Weather{
        let urlPath = WeatherURL(lat: String(coords.latitude), long: String(coords.longitude)).getFullURL()
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let queue: NSOperationQueue = NSOperationQueue()
        
        if (wVCId == WeatherViewControllerId.today) {
            NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                do {
                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                        if let currently = jsonResult["currently"] as? Dictionary<String, AnyObject>{
                            print(currently)
     
                            
                            
                            
                            //if let temperature = currently["temperature"] as? Double{
                            //    self.currentTemp = temperature
                           // }
                        }
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            })
        } else if (wVCId == WeatherViewControllerId.tomorrow) {
            print("tomorrowfhr")
        
            
        } else if (wVCId == WeatherViewControllerId.sevenDay) {
            print("7day")
        }
        else {
            print("how did I get here??")
        }
        let a = Weather(json: ["precipIntensity": 0, "icon": "clear-night", "time": 1495658390, "precipProbability": 0, "windSpeed": 2.64, "nearestStormBearing": 19, "summary": "Clear", "apparentTemperature": 62.25, "dewPoint": 55.43, "nearestStormDistance": 293, "cloudCover": 0.08, "humidity": 0.78, "windBearing": 4, "temperature": 62.25, "visibility": 7.15, "pressure": 1025.28, "ozone": 319.98])
        return a
        
    }
}