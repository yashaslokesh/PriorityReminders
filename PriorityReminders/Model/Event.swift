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
        let image = aDecoder.decodeObject(forKey: EventProperties.eventImage) as! UIImage
        
        self.init(name: name, startDate: startDate, endDate: endDate, description: description, image : image)
        
    }
    
    //MARK: Types of data used in the application (for each Event)
    
    struct EventProperties {
        static let eventName = "name"
        static let eventStartDate = "startDate"
        static let eventEndDate = "endDate"
        static let eventDescription = "description"
        static let eventImage = "image"
    }
    
    //MARK: Properties
    
    var eventName : String
    var eventStartDate : Date
    var eventEndDate : Date
    var eventDescription : String?
    var eventImage : UIImage
    
    
    //MARK: Local path for archiving Event instances
    
    static let FilesDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchivingURL = FilesDirectory.appendingPathComponent("priority_events")
    
    //MARK: Class Instance Initializer
    
    init?(name : String, startDate : Date, endDate : Date, description : String?, image : UIImage) {
        
        guard endDate > startDate else {
            return nil
        }
        
        self.eventName = name
        self.eventStartDate = startDate
        self.eventEndDate = endDate
        self.eventDescription = description
        self.eventImage = image
    }
    
    //MARK: NSCoding
    // Used to encode the events and store them
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(eventName, forKey: EventProperties.eventName)
        aCoder.encode(eventStartDate, forKey: EventProperties.eventStartDate)
        aCoder.encode(eventEndDate, forKey: EventProperties.eventEndDate)
        aCoder.encode(eventDescription, forKey: EventProperties.eventDescription)
        aCoder.encode(eventImage, forKey: EventProperties.eventImage)
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
    
    // Will calculate time to set notification?
    // To be completed in future
    static func notificationDateCalculator( frequency : Int, units : String) -> DateComponents {
        var date = DateComponents()
        
        return date
    }
    
    // From: https://developer.apple.com/documentation/uikit/uiimage/1624096-pngdata
    private static func areImagesEqual(image1 : UIImage, image2 : UIImage) -> Bool {
        let image1Data : Data? = image1.pngData()
        let image2Data : Data? = image2.pngData()
        return image1Data == image2Data
    }
}

// From: https://developer.apple.com/documentation/swift/customstringconvertible/1539130-description
// Defines the description, which will be printed when calling String(event_instance)
// No need to implement CustomStringConvertible because NSObject already does that
extension Event {
    override var description : String {
        return "Event Name: \(eventName)\n" + "Start Date: \(eventStartDate)\n" + "End Date: \(eventEndDate)\n" + "Description: \(eventDescription ?? "N/A")\n"
    }
}

// From: https://developer.apple.com/documentation/swift/equatable
// Defines the equality operator for comparing two events
extension Event {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.eventName == rhs.eventName &&
               lhs.eventStartDate == rhs.eventStartDate &&
               lhs.eventEndDate == rhs.eventEndDate &&
               lhs.eventDescription == rhs.eventDescription &&
               areImagesEqual(image1: lhs.eventImage, image2: rhs.eventImage)
    }
}
