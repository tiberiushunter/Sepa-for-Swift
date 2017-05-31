//
//  LocationViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 23/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var coords = CLLocationCoordinate2D(latitude: 53.4846, longitude: -2.2708)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        guard status == .AuthorizedAlways else {
            return
        }
        mapView.showsUserLocation = true
        mapView.showsCompass = true
    }
    
    func getLocation(){
        if let loc = locationManager.location?.coordinate{
            coords = loc
        }
        mapView.showsUserLocation = true
    }
    
    @IBAction func AddLocation(sender: AnyObject) {
        getLocation()
        
        let lat = coords.latitude
        let long = coords.longitude
        NSUserDefaults.standardUserDefaults().setDouble(lat, forKey:"lastLat")
        NSUserDefaults.standardUserDefaults().setDouble(long, forKey:"lastLong")
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
