//
//  WeatherTomorrowViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 23/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit
import MapKit

class WeatherTomorrowViewController: UIViewController, CLLocationManagerDelegate {
  //  var weatherModel = WeatherModel(Id: WeatherViewControllerId.tomorrow)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     //   weatherModel = WeatherModel(Id: WeatherViewControllerId.tomorrow)

     //   weatherModel.locationManager.delegate = self
     //   weatherModel.locationManager.desiredAccuracy = kCLLocationAccuracyBest
     //   weatherModel.locationManager.requestAlwaysAuthorization()
     //   weatherModel.locationManager.startUpdatingLocation()
        
        
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
      //      weatherModel.getLocation()
        } else if (status == .Denied){
            let alert = UIAlertController(title: "Error", message: "Goto Settings and allow this app to access your location", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

}
