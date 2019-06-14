//
//  UIViewExt.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 6/13/19.
//  Copyright © 2019 Yashas Lokesh. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addConstraints(withFormat: String, forViews: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in forViews.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: withFormat,
                                                      options: NSLayoutConstraint.FormatOptions(),
                                                      metrics: nil,
                                                      views: viewsDictionary))
        
    }
    
}
