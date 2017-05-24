//
//  WeatherTodayViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 19/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit
import MapKit

class WeatherTodayViewController: UIViewController, CLLocationManagerDelegate {
    let w = WeatherModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        w.locationManager.delegate = self
        w.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        w.locationManager.requestAlwaysAuthorization()
        w.locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        
        //let newLat = String(format: "%f", w.coords.latitude)
        //let newLong = String(format: "%f", w.coords.longitude)
        
        //print("Location Changed. Latitude: " + newLat + " Longitude: " + newLong)
        
        if (status == .AuthorizedAlways){
            w.getLocation()
        } else if (status == .Denied){
            let alert = UIAlertController(title: "Error", message: "Goto Settings and allow this app to access your location", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
   }

