//
//  EventTableViewCell.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 5/28/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var daysLeftNumberLabel: UILabel!
    @IBOutlet weak var timeDoneLabel: UILabel!
    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    var labelsArray = [UILabel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        labelsArray.append(nameLabel)
        labelsArray.append(daysLeftLabel)
        labelsArray.append(daysLeftNumberLabel)
        labelsArray.append(timeDoneLabel)
        labelsArray.append(doneLabel)
        labelsArray.append(endDateLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
