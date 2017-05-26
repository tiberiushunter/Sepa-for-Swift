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
    
}
