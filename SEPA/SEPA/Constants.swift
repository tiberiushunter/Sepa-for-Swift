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

enum WeatherIcon: String {
    case clearDay = "sunny"
    case clearNight = "full-moon"
    case rain = "showers"
    case snow = "snow"
    case wind = "windy"
    case fog = "fog"
    case cloudy = "sun-cloudy"
    case partlyCloudyDay = "sunny-to-cloudy"
    case partlyCloudyNight = "new-moon"
    case thunderstorm = "thunder"
    case tornado = "stormy"
    case nothing = ""
}



/*
 clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night. (Developers should ensure that a sensible default is defined, as additional values, such as hail, thunderstorm, or tornado, may be defined in the future.)
 */

struct UnixTimeURL {
    private let baseURL = "http://www.convert-unix-time.com/api?"
    private var timestamp = ""
    private let format = "&format=english"
    private let timezone = "&timezone=London"
    
    init (timestamp: String){
        self.timestamp = "timestamp=\(timestamp)"

    }
    
    func getFullURL() -> String {
        return baseURL + timestamp + format + timezone
    }
}