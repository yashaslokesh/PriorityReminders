//
//  SettingsTableViewCell.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 6/3/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var settingOptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setOptionLabelText(text : String) -> Void {
        self.settingOptionLabel.text = text
    }

}
