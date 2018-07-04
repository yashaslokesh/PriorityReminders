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
    
    // an initializer to test the decoding of the name object, at a minimum, and then decodes the rest of the properties
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: EventProperties.eventName) as? String else {
            os_log("Unable to decode an Event object's name.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let startDate = aDecoder.decodeObject(forKey: EventProperties.eventStartDate) as! Date
        let endDate = aDecoder.decodeObject(forKey: EventProperties.eventEndDate) as! Date
        let description = aDecoder.decodeObject(forKey: EventProperties.eventDescription) as? String
        
        self.init(name: name, startDate: startDate, endDate: endDate, description: description)
        
    }
    
    //MARK: Types of data used in the application (for each Event)
    
    struct EventProperties {
        static let eventName = "name"
        static let eventStartDate = "startDate"
        static let eventEndDate = "endDate"
        static let eventDescription = "description"
    }
    
    //MARK: Properties
    
    var eventName : String
    var eventStartDate : Date
    var eventEndDate : Date
    var eventDescription : String?
    
    //MARK: Local path for archiving Event instances
    
    static let FilesDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchivingURL = FilesDirectory.appendingPathComponent("events")
    
    //MARK: Class Instance Initializer
    
    init?(name : String, startDate : Date, endDate : Date, description : String?) {
        
        guard endDate > startDate else {
            return nil
        }
        
        self.eventName = name
        self.eventStartDate = startDate
        self.eventEndDate = endDate
        self.eventDescription = description
    }
    
    //MARK: NSCoding
    // Used to encode the events and store them
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(eventName, forKey: EventProperties.eventName)
        aCoder.encode(eventStartDate, forKey: EventProperties.eventStartDate)
        aCoder.encode(eventEndDate, forKey: EventProperties.eventEndDate)
        aCoder.encode(eventDescription, forKey: EventProperties.eventDescription)
    }
    
    // Functions to get statistics about the dates
    
    func daysLeft() -> Int {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.day], from: Date(), to: eventEndDate)
        
        return components.day ?? 0
    }
    
    func percentageDone() -> Double {
        
        let calendar = Calendar.current
        
        let totalDays = calendar.dateComponents([.day], from: eventStartDate, to: eventEndDate)
        
        var percentage : Double? = nil
        
        if let total = totalDays.day {
            percentage = 100.0 * ( 1.0 - (Double(daysLeft()) / Double(total)) )
            percentage = Double(floor(100 * percentage!) / 100)
        }
        
        return percentage ?? 0.00
    }
    
    static func notificationDateCalculator( frequency : Int, units : String) -> DateComponents {
        var date = DateComponents()
        
        return date
    }
    
}
