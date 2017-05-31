//
//  DashboardTableViewCell.swift
//  SEPA
//
//  Created by Welek Samuel on 23/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    

    @IBOutlet weak var dashboardIcon: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var summary: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
