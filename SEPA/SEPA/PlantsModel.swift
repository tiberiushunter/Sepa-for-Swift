//
//  PlantsModel.swift
//  SEPA
//
//  Created by Welek Samuel on 28/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import Foundation

class PlantsModel {
    private var timestamp: String
    private var ambientLight: String
    private var externalLight: String
    private var soilMoisture: String
    private var hardwareTemperature: String
    private var externalTemperature: String
    private var ambientHumidity: String
    private var ambientTemperature: String
    
    required init(timestamp: String, ambientLight: String, externalLight: String, soilMoisture: String, hardwareTemperature: String, externalTemperature: String, ambientHumidity: String, ambientTemperature: String){
        self.timestamp = timestamp
        self.ambientLight = ambientLight
        self.externalLight = externalLight
        self.soilMoisture = soilMoisture
        self.hardwareTemperature = hardwareTemperature
        self.externalTemperature = externalTemperature
        self.ambientHumidity = ambientHumidity
        self.ambientTemperature = ambientTemperature
    }
    
    func getTimestamp() -> String{
        return timestamp
    }
    
    func getAmbientLight() -> String{
        return ambientLight
    }
    
    func getExternalLight() -> String{
        return externalLight
    }
    
    func getSoilMoisture() -> String{
        return soilMoisture
    }
    
    func getHardwareTemperature() -> String{
        return hardwareTemperature
    }
    
    func getExternalTemperature() -> String{
        return externalTemperature
    }
    
    func getAmbientHumidity() -> String{
        return ambientHumidity
    }
    
    func getAmbientTemperature() -> String{
        return ambientTemperature
    }
    
    func setTimestamp(timestamp: String){
        self.timestamp = timestamp
    }
    
    func setAmbientLight(ambientLight: String){
        self.ambientLight = ambientLight
    }
    
    func setExternalLight(externalLight: String){
        self.externalLight = externalLight
    }
    
    func setSoilMoisture(soilMoisture: String){
        self.soilMoisture = soilMoisture
    }
    
    func setHardwareTemperature(hardwareTemperature: String){
        self.hardwareTemperature = hardwareTemperature
    }
    
    func setExternalTemperature(externalTemperature: String){
        self.externalTemperature = externalTemperature
    }
    
    func setAmbientHumidity(ambientHumidity: String){
        self.ambientHumidity = ambientHumidity
    }
    
    func setAmbientTemperature(ambientTemperature: String){
        self.ambientTemperature = ambientTemperature
    }
}