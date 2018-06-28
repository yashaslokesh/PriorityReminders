//
//  EventTableViewCell.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 5/28/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit

protocol EventTableViewCellDelegate : class {
    func didTapButton(_ cell : EventTableViewCell)
}

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var accessoryInfoLabel: UILabel!
    @IBOutlet weak var accessoryInfoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let color = accessoryInfoButton.currentTitleColor
        
        accessoryInfoButton.layer.borderWidth = 1.0
        accessoryInfoButton.layer.cornerRadius = 10.0
        accessoryInfoButton.layer.borderColor = color.cgColor
        accessoryInfoButton.titleColor(for: .normal)
        nameLabel.font = UIFont(name: "Avenir-Medium", size: 25.0)
        accessoryInfoLabel.font = UIFont(name: "Avenir-Medium", size: 17.0)
        accessoryInfoButton.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 22.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    weak var delegate : EventTableViewCellDelegate?
    @IBAction func accessoryInfoDisplayAction(_ sender: Any) {
        delegate?.didTapButton(self)
    }
    
    
    func setLabelsTextColor(color : UIColor) -> Void {
        nameLabel.textColor = color
        accessoryInfoLabel.textColor = color
    }

}
