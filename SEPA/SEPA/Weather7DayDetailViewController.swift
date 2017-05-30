//
//  Weather7DayDetailViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 19/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit
import MapKit

class Weather7DayDetailViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var coords = CLLocationCoordinate2D(latitude: 53.4846, longitude: -2.2708)
    
    var timestamp = ""
    
    var summary = ""
    var temperatureMinimum = 0.00
    var temperatureMaximum = 0.00
    var feelLikeTemperaure = 0.00
    var windDirection = 0.00
    var windSpeed = 0.00
    var chanceOfRain = 0.00
    var rainIntensity = 0.00
    var nearestStormDistance = 0.00
    var nearestStormDirection = 0.00
    var imageIcon = WeatherIcon.nothing
    
    @IBOutlet weak var topStackView: UIStackView!
    
    @IBOutlet weak var detailsStackView: UIStackView!
 
    @IBOutlet weak var lblMinTemp: UILabel!
    
    @IBOutlet weak var lblMaxTemp: UILabel!
    
    @IBOutlet weak var lblSummary: UILabel!
    
    @IBOutlet weak var lblWindDirection: UILabel!
    
    @IBOutlet weak var lblWindSpeed: UILabel!
    
    @IBOutlet weak var lblChanceOfRain: UILabel!
    
    @IBOutlet weak var lblRainIntensity: UILabel!
    
    @IBOutlet weak var lblNearestStormDistance: UILabel!
    
    @IBOutlet weak var lblNearestStormDirection: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.timestamp + " - Detail"
        
        let orientation = UIApplication.sharedApplication().statusBarOrientation
        
        if orientation.isPortrait {
            self.topStackView.axis = .Vertical
        } else {
            self.topStackView.axis = .Horizontal
        }
        
        self.lblSummary.text = self.summary
        
        self.lblMinTemp.text = String(format: "%.0f", Utilities().convertToCelsius(self.temperatureMinimum)) + "°C"
        self.lblMaxTemp.text = String(format: "%.0f", Utilities().convertToCelsius(self.temperatureMaximum)) + "°C"
        self.lblWindDirection.text = String(format: "%.0f", self.windDirection) + "°N"
        self.lblWindSpeed.text = String(format: "%.2f", self.windSpeed) + "mph"
        self.lblChanceOfRain.text = String(format: "%.0f", self.chanceOfRain * 100) + "%"
        self.lblRainIntensity.text = String(format: "%.2f", self.rainIntensity)
        self.lblNearestStormDistance.text = String(format: "%.0f", self.nearestStormDistance) + " miles"
        self.lblNearestStormDirection.text = String(format: "%.0f", self.nearestStormDirection) + "°N"
        self.weatherImage.image = UIImage(named:self.imageIcon.rawValue)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator:UIViewControllerTransitionCoordinator) {
        
        coordinator.animateAlongsideTransition({ (context) -> Void in
            
            let orientation = UIApplication.sharedApplication().statusBarOrientation
            
            if orientation.isPortrait {
                self.topStackView.axis = .Vertical
            } else {
                self.topStackView.axis = .Horizontal
            }
            
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}