//
//  TabBarController.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 6/13/19.
//  Copyright © 2019 Yashas Lokesh. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        
        let eventsMasterController = EventsViewController(collectionViewLayout: layout)
        let eventsMasterNavController = UINavigationController(rootViewController: eventsMasterController)
        eventsMasterNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        
        let settingsViewController = SettingsViewController(collectionViewLayout: layout)
        let settingsNavController = UINavigationController(rootViewController: settingsViewController)
        settingsNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        
        viewControllers = [eventsMasterNavController, settingsNavController]
        
    }
}
