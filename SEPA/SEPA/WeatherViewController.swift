//
//  WeatherTodayViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 19/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit
import MapKit

class WeatherTodayViewController: UIViewController,CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var coords = CLLocationCoordinate2D(latitude: 53.4846, longitude: -2.2708)
    var temperature = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        
        let newLat = String(format: "%f", coords.latitude)
        let newLong = String(format: "%f", coords.longitude)
        
        print("Location Changed. Latitude: " + newLat + " Longitude: " + newLong)
        
        if (status == .AuthorizedAlways){
            getLocation()
        } else if (status == .Denied){
            let alert = UIAlertController(title: "Error", message: "Goto Settings and allow this app to access your location", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func convertToCelsius(fahrenheit: Int) -> Int {
        return Int(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
    }
    
    func getLocation(){
        if let loc = locationManager.location?.coordinate{
            coords = loc
        }
        getWeatherData()
        
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
}

