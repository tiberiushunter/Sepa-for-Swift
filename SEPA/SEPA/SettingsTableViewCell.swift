//
//  SettingsTableViewCell
//  SEPA
//
//  Created by Welek Samuel on 28/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblSetting: UILabel!

    @IBOutlet weak var `switch`: UISwitch!
    
    @IBOutlet weak var newsLogo: UIImageView!
    
    var setting = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)
    }

    @IBAction func switchAction(sender: AnyObject) {
        if `switch`.on {
            NSUserDefaults.standardUserDefaults().setObject(Bool(true), forKey:"newsSource_" + setting)
        } else {
            NSUserDefaults.standardUserDefaults().setObject(Bool(false), forKey:"newsSource_" + setting)
        }
    }
    
}