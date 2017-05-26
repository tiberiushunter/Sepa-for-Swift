//
//  WeatherAPIModel.swift
//  SEPA
//
//  Created by Welek Samuel on 24/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import Foundation

class Weather {
    var Time: Int64?
    var Summary: String?
    var Icon: String?
    var NearestStormDistance: Double?
    var PrecipIntensity: Double?
    var PrecipIntensityError: Double?
    var PrecipProbability: Double?
    var PrecipType: String?
    var Temperature: Double?
    var ApparentTemperature: Double?
    var DewPoint: Double?
    var Humidity: Double?
    var WindSpeed: Double?
    var WindBearing: Double?
    var Visibility: Double?
    var CloudCover: Double?
    var Pressure: Double?
    var Ozone: Double?
    
    init(){
        
    }
    
    init(json: [String: AnyObject]) {
        self.Time = json[Current.Time.rawValue] as? Int64
        self.Summary = json[Current.Summary.rawValue] as? String
        self.Icon = json[Current.Icon.rawValue] as? String
        self.NearestStormDistance = json[Current.NearestStormDistance.rawValue] as? Double
        self.PrecipIntensity = json[Current.PrecipIntensity.rawValue] as? Double
        self.PrecipIntensityError = json[Current.PrecipIntensityError.rawValue] as? Double
        self.PrecipProbability = json[Current.PrecipProbability.rawValue] as? Double
        self.PrecipType = json[Current.PrecipType.rawValue] as? String
        self.Temperature = json[Current.Temperature.rawValue] as? Double
        self.ApparentTemperature = json[Current.ApparentTemperature.rawValue] as? Double
        self.DewPoint = json[Current.DewPoint.rawValue] as? Double
        self.Humidity = json[Current.Humidity.rawValue] as? Double
        self.WindSpeed = json[Current.WindSpeed.rawValue] as? Double
        self.WindBearing = json[Current.WindBearing.rawValue] as? Double
        self.Visibility = json[Current.Visibility.rawValue] as? Double
        self.CloudCover = json[Current.CloudCover.rawValue] as? Double
        self.Pressure = json[Current.Pressure.rawValue] as? Double
        self.Ozone = json[Current.Ozone.rawValue] as? Double
        
    }
    
    enum Current: String {
        case Time = "time"
        case Summary = "summary"
        case Icon = "icon"
        case NearestStormDistance = "nearestStormDistance"
        case PrecipIntensity = "precipIntensity"
        case PrecipIntensityError = "precipIntensityError"
        case PrecipProbability = "precipProbability"
        case PrecipType = "precipType"
        case Temperature = "temperature"
        case ApparentTemperature = "apparentTemperature"
        case DewPoint = "dewPoint"
        case Humidity = "humidity"
        case WindSpeed = "windSpeed"
        case WindBearing = "windBearing"
        case Visibility = "visibility"
        case CloudCover = "cloudCover"
        case Pressure = "pressure"
        case Ozone = "ozone"
    }

}
