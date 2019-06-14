//
//  BaseCollectionCell.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 6/13/19.
//  Copyright © 2019 Yashas Lokesh. All rights reserved.
//

import Foundation
import UIKit

class BaseCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {}
}
