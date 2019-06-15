//
//  EventsViewExt.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 6/13/19.
//  Copyright © 2019 Yashas Lokesh. All rights reserved.
//

import Foundation
import UIKit

extension EventsViewController {
    // This extension is mainly used for managing the test data. Core Data will be setup and tested here
    
    func clearData() {
        
    }
    
    func setupTestData() {
        clearData()
        
        let dayInSeconds: Double = 60 * 60 * 24
        let weekInSeconds: Double = dayInSeconds * 7
        let yearInSeconds: Double = dayInSeconds * 365.25
        
        guard let eventOne = Event(name: "Eat Breakfast", endDate: Date(timeInterval: yearInSeconds * 5, since: Date()), decsr: "Don't forget to eat breakfast!", imageName: "breakfast") else {
            return
        }
        
        guard let eventTwo = Event(name: "Be Awesome", endDate: Date(timeInterval: yearInSeconds * 6, since: Date()), decsr: "Be awesome everyday, as John and Hank Green might say", imageName: "awesome") else {
            return
        }
        
        guard let eventThree = Event(name: "Explore the World", endDate: Date(timeInterval: yearInSeconds * 7, since: Date()), decsr: "Explore the world, see everything you want to see, carpe diem.", imageName: "world") else {
            return
        }
        
        events += [eventOne, eventTwo, eventThree]
    }
}
