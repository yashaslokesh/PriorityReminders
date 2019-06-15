//
//  Event+CoreDataClass.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 6/14/19.
//  Copyright © 2019 Yashas Lokesh. All rights reserved.
//
//

import Foundation
import CoreData

// The Event properties class is regenerated automatically with each build
// since the "Event" entity is described in the data model file.
// This class is used for convenience and business logic methods
@objc(Event)
public class Event: NSManagedObject {
    
    func daysLeft() -> Int {
        let calendar = Calendar.current
        
    }
    
}
