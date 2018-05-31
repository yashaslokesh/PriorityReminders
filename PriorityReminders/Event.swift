//
//  Event.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 5/28/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit
import os.log

class Event : NSObject, NSCoding {
    
    // an initializer to test the decoding of the name object, at a minimum
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: EventProperties.eventName) as? String else {
            os_log("Unable to decode an Event object's name.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let startDate = aDecoder.decodeObject(forKey: EventProperties.eventStartDate) as! Date
        let endDate = aDecoder.decodeObject(forKey: EventProperties.eventEndDate) as! Date
        let priority = aDecoder.decodeInteger(forKey: EventProperties.eventPriority)
        let description = aDecoder.decodeObject(forKey: EventProperties.eventDescription) as? String
        
        self.init(name: name, startDate: startDate, endDate: endDate, description: description, priority: priority)
        
    }
    
    //MARK: Types of data used in the application (for each Event)
    
    struct EventProperties {
        static let eventName = "name"
        static let eventStartDate = "startDate"
        static let eventEndDate = "endDate"
        static let eventPriority = "priority"
        static let eventDescription = "description"
    }
    
    //MARK: Properties
    
    var eventName : String
    var eventStartDate : Date
    var eventEndDate : Date
    var eventPriority : Int
    var eventDescription : String?
    
    //MARK: Local path for archiving Event instances
    
    static let FilesDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchivingURL = FilesDirectory.appendingPathComponent("events")
    
    //MARK: Class Instance Initializer
    
    init?(name : String, startDate : Date, endDate : Date, description : String?, priority : Int) {
        
        guard endDate > startDate else {
            return nil
        }
        
        self.eventName = name
        self.eventStartDate = startDate
        self.eventEndDate = endDate
        self.eventPriority = priority
        self.eventDescription = description
    }
    
    //MARK: NSCoding
    // Used to encode the events and store them
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(eventName, forKey: EventProperties.eventName)
        aCoder.encode(eventStartDate, forKey: EventProperties.eventStartDate)
        aCoder.encode(eventEndDate, forKey: EventProperties.eventEndDate)
        aCoder.encode(eventPriority, forKey: EventProperties.eventPriority)
        aCoder.encode(eventDescription, forKey: EventProperties.eventDescription)
    }
    
}
