//
//  EventTableViewCell.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 5/28/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit

protocol EventViewCellDelegate : class {
    func didTapButton(_ cell : EventViewCell)
}

class EventViewCell: BaseCollectionCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor(red: 0, green: 134/255, blue: 249/255, alpha: 1) : UIColor.white
            setLabelsTextColor(color: isHighlighted ? .white : .black)
        }
    }
    
    let previewImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "Name"
        return label
    }()
    
    
    let eventInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = "Date"
        return label
    }()
    
    // Replaces accessory info label's functionality
    // This label changes based on the eventInfoLabel's state
    let eventInfoTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Date Type"
        return label
    }()
    
    override func setup() {
        super.setup()
        
        addSubview(nameLabel)
        
        let rightContainerView = UIView()
        addSubview(rightContainerView)
        
        addConstraints(withFormat: "H:|-[v0]-[v1(<=100)]-|", forViews: nameLabel, rightContainerView)
        addConstraints(withFormat: "V:|-[v0]-|", forViews: nameLabel)
        addConstraints(withFormat: "V:|-[v0]-|", forViews: rightContainerView)
        
        rightContainerView.addSubview(eventInfoLabel)
        rightContainerView.addSubview(eventInfoTypeLabel)
        
        rightContainerView.addConstraints(withFormat: "H:|[v0]|", forViews: eventInfoTypeLabel)
//        rightContainerView.addConstraints(withFormat: "H:|[v0]|", forViews: eventInfoLabel)
        rightContainerView.addConstraints(withFormat: "V:|[v0]-[v1]|", forViews: eventInfoTypeLabel, eventInfoLabel)
        
        // toItem must be the direct superview of the eventInfoLabel, in this case, it is rightContainerView
        rightContainerView.addConstraint(NSLayoutConstraint(item: eventInfoLabel, attribute: .centerX, relatedBy: .equal, toItem: rightContainerView, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//
//        let color = accessoryInfoButton.currentTitleColor
//        print(color)
//
//        accessoryInfoButton.layer.borderWidth = 1.0
//        accessoryInfoButton.layer.cornerRadius = 10.0
//        accessoryInfoButton.layer.borderColor = color.cgColor
//        accessoryInfoButton.titleColor(for: .normal)
//        nameLabel.font = UIFont(name: "Avenir-Medium", size: 25.0)
//        accessoryInfoLabel.font = UIFont(name: "Avenir-Medium", size: 17.0)
//        accessoryInfoButton.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 22.0)
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
//    weak var delegate : EventViewCellDelegate?
//    @IBAction func accessoryInfoDisplayAction(_ sender: Any) {
//        delegate?.didTapButton(self)
//    }
    
    
    func setLabelsTextColor(color : UIColor) {
        nameLabel.textColor = color
        eventInfoLabel.textColor = color
        eventInfoTypeLabel.textColor = color
    }

}
