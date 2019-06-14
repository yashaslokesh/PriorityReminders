//
//  SettingsTableViewCell.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 6/3/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit

class SettingsViewCell: BaseCollectionCell {
    
//    @IBOutlet weak var settingOptionLabel: UILabel!
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "A Settings Options"
        return label
    }()
    
    override func setup() {
        addSubview(nameLabel)
        
        addConstraints(withFormat: "H:|-12-[v0]-12-|", forViews: nameLabel)
        addConstraints(withFormat: "V:|-[v0]-|", forViews: nameLabel)
    }

}
