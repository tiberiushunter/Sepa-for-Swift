//
//  Weather48HourTableCell.swift
//  SEPA
//
//  Created by Welek Samuel on 28/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit

class Weather48HourTableCell: UITableViewCell {
    

    @IBOutlet weak var weatherIcon: UIImageView!

    @IBOutlet weak var lblSummary: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblTemperature: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)
        
        
        
    }

}
