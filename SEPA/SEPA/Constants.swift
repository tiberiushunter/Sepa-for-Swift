//
//  Constants.swift
//  SEPA
//
//  Created by Welek Samuel on 23/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import Foundation

struct WeatherURL {
    private let baseURL = "https://api.darksky.net/forecast/"
    private let key = "e0b934246f6646b9e8fa88b86bf27f3b/"
    private var coordStr = ""
    
    init (lat: String, long: String){
        self.coordStr = "\(lat),\(long)"
    }
    
    func getFullURL() -> String {
        return baseURL + key + coordStr
    }
}

enum WeatherViewControllerId: Int {
    case today = 1
    case tomorrow = 2
    case sevenDay = 3
    case nothing = 0

}

func convertToCelsius(fahrenheit: Int) -> Int {
    return Int(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
}