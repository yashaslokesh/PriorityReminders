//
//  Event.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 5/28/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit

class Event {
    
    //MARK: Properties
    
    var eventName : String
    var eventStartDate : Date
    var eventEndDate : Date
    var eventPriority : Int
    
    init?(name : String, startDate : Date, endDate : Date, priority : Int) {
        
        guard endDate > startDate else {
            return nil
        }
        
        self.eventName = name
        self.eventStartDate = startDate
        self.eventEndDate = endDate
        self.eventPriority = priority
    }
    
}
