//
//  Extensions.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 6/6/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit

extension UIView {
    
    func textChangeTransition(_ duration : CFTimeInterval) -> Void {
        let animation : CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.type = kCATransitionFade
        animation.duration = duration
        layer.add(animation, forKey: "textChangeTransition")
    }
}
