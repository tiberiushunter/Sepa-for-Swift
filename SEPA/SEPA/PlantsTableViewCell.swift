//
//  PlantsTableViewCell.swift
//  SEPA
//
//  Created by Welek Samuel on 28/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit

class PlantsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var timestamp: UILabel!
    
    @IBOutlet weak var ambientLight: UILabel!
    
    @IBOutlet weak var externalLight: UILabel!
    
    @IBOutlet weak var soilMoisture: UILabel!
    
    @IBOutlet weak var hardwareTemperature: UILabel!
    
    @IBOutlet weak var externalTemperature: UILabel!
    
    @IBOutlet weak var ambientHumidity: UILabel!
    
    @IBOutlet weak var ambientTemperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)
    }
}