//
//  SettingsTableViewCell.swift
//  Membot
//
//  Created by Alex Andrews on 3/10/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var settingCellLabel: UILabel!
    @IBOutlet weak var settingCellSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    @IBAction func settingsCellSwitchChanged(sender: AnyObject) {
        print("eat worms")
    }
}
