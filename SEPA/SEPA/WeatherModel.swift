//
//  WeatherModel.swift
//  SEPA
//
//  Created by Welek Samuel on 28/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import Foundation

class WeatherModel {
    private var time: Double
    private var icon: String
    private var temperature: Double
    private var apparentTemperature: Double
    private var summary: String
    private var windDirection: Double
    private var windSpeed: Double
    private var chanceOfRain: Double
    private var rainIntensity: Double
    private var nearestStormDistance: Double
    private var nearestStormDirection: Double
    
    init(time: Double, icon: String, temperature: Double, apparentTemperature: Double, summary: String, windDirection: Double, windSpeed: Double, chanceOfRain: Double, rainIntensity: Double){
        self.time = time
        self.icon = icon
        self.temperature = temperature
        self.apparentTemperature = apparentTemperature
        self.summary = summary
        self.windDirection = windDirection
        self.windSpeed = windSpeed
        self.chanceOfRain = chanceOfRain
        self.rainIntensity = rainIntensity
        self.nearestStormDistance = 0.00
        self.nearestStormDirection = 0.00
    }
    
    init(time: Double, icon: String, temperature: Double, apparentTemperature: Double, summary: String, windDirection: Double, windSpeed: Double, chanceOfRain: Double, rainIntensity: Double, nearestStormDirection: Double, nearestStormDistance: Double){
        self.time = time
        self.icon = icon
        self.temperature = temperature
        self.apparentTemperature = apparentTemperature
        self.summary = summary
        self.windDirection = windDirection
        self.windSpeed = windSpeed
        self.chanceOfRain = chanceOfRain
        self.rainIntensity = rainIntensity
        self.nearestStormDistance = nearestStormDistance
        self.nearestStormDirection = nearestStormDirection
    }
    
    func getTime() -> Double{
        return time
    }
    
    func getIcon() -> String{
        return icon
    }
    
    func getTemperature() -> Double{
        return temperature
    }
    
    func getApparentTemperature() -> Double{
        return apparentTemperature
    }

    func getSummary() -> String{
        return summary
    }

    func getWindDirection() -> Double{
        return windDirection
    }

    func getWindSpeed() -> Double{
        return windSpeed
    }

    func getChanceOfRain() -> Double{
        return chanceOfRain
    }

    func getRainIntensity() -> Double{
        return rainIntensity
    }
/*
    func getNearestStormDistance() -> Double{
        return nearestStormDistance
    }

    func getNearestStormDirection() -> Double{
        return nearestStormDirection
    }
 
 */
    
    func setTime(time: Double){
        self.time = time
    }
    
    func setIcon(icon: String){
        self.icon = icon
    }
    
    func setTemperature(temperature: Double){
        self.temperature = temperature
    }
    
    func setApparentTemperature(apparentTemperature: Double){
        self.apparentTemperature = apparentTemperature
    }
    
    func setSummary(summary: String){
        self.summary = summary
    }
    
    func setWindDirection(windDirection: Double){
        self.windDirection = windDirection
    }
    
    func setWindSpeed(windSpeed: Double){
        self.windSpeed = windSpeed
    }
    
    func setChanceOfRain(chanceOfRain: Double){
        self.chanceOfRain = chanceOfRain
    }
    
    func setRainIntensity(rainIntensity: Double){
        self.rainIntensity = rainIntensity
    }
    
    func setNearestStormDistance(nearestStormDistance: Double){
        self.nearestStormDistance = nearestStormDistance
    }
    
    func setNearestStormDirection(nearestStormDirection: Double){
        self.nearestStormDirection = nearestStormDirection
    }
 

}
