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
    
    var temperature = 0.00
    
    func getLocation() -> CLLocationCoordinate2D{
        if let loc = locationManager.location?.coordinate{
            return loc
        }
        getWeatherData()
        return coords
    }
    
    func getWeatherData(){
        let urlPath = WeatherURL(lat: String(coords.latitude), long: String(coords.longitude)).getFullURL()
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let queue: NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            do {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    if let currently = jsonResult["currently"] as? Dictionary<String, AnyObject>{
                        if let temperature = currently["temperature"] as? Double{
                            self.temperature = temperature
                        }
                    }
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        })
        
    }
    
    func convertToCelsius(fahrenheit: Int) -> Int {
        return Int(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
    }
}