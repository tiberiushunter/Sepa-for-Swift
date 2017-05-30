//
//  Weather7DayTableCell.swift
//  SEPA
//
//  Created by Welek Samuel on 28/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit

class Weather7DayTableCell: UITableViewCell {
    
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var lblSummary: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblTemperature: UILabel!
    
    var timestamp = ""
    var summary = ""
    var temperatureMinimum = 0.00
    var temperatureMaximum = 0.00
    var windDirection = 0.00
    var windSpeed = 0.00
    var chanceOfRain = 0.00
    var rainIntensity = 0.00
    var nearestStormDistance = 0.00
    var nearestStormDirection = 0.00
    var imageIcon = WeatherIcon.nothing
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)
    }
    
}
