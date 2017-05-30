//
//  LocationDataModel.swift
//  SEPA
//
//  Created by Welek Samuel on 30/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import Foundation

class VisitedPoint {
    
    var latitude: String
    var longitude: String
    
    init(lat: String, long: String){
        self.latitude = lat
        self.longitude = long
    }
}