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
    
    convenience init?(name: String, startDate: Date = Date(), endDate: Date, decsr: String, imageName: String) {
        // Ensure dates are valid
        guard endDate > startDate else {
            fatalError("End date comes before start date")
        }
        
        let context = AppDelegate.viewContext
        
        self.init(context: context)
        
        self.name = name
        self.startDate = startDate as NSDate
        self.endDate = endDate as NSDate
        self.descr = descr
        self.imageName = imageName
    }
    
    func daysLeft() -> Int {
        let calendar = Calendar.current
        
        let daysToStart = calendar.dateComponents([.day], from: Date(), to: startDate as Date)
        let daysToEnd = calendar.dateComponents([.day], from: Date(), to: endDate as Date)
        
        if let daysLeft = daysToStart.day, daysLeft > 0 {
            return daysLeft
        }
        
        return daysToEnd.day ?? 0
    }
    
    func percentageDone() -> Double {
        
        let calendar = Calendar.current
        
        let totalDays = calendar.dateComponents([.day], from: startDate as Date, to: endDate as Date)
        
        var percentage : Double?
        
        if let total = totalDays.day {
            percentage = 100.0 * ( 1.0 - (Double(daysLeft()) / Double(total)) )
            percentage = Double(floor(100 * percentage!) / 100)
        }
        
        return percentage ?? 0.00
    }
    
}

// From: https://developer.apple.com/documentation/swift/customstringconvertible/1539130-description
// Defines the description, which will be printed when calling String(event_instance)
// No need to implement CustomStringConvertible because NSObject already does that
extension Event {
    override public var description : String {
        return "Event Name: \(name)\n" + "Start Date: \(startDate)\n" + "End Date: \(endDate)\n" + "Description: \(descr)\n"
    }
}

// From: https://developer.apple.com/documentation/swift/equatable
// Defines the equality operator for comparing two events
extension Event {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.name == rhs.name &&
            lhs.startDate == rhs.startDate &&
            lhs.endDate == rhs.endDate &&
            lhs.descr == rhs.descr &&
            lhs.imageName == rhs.imageName
//            areImagesEqual(image1: lhs.eventImage, image2: rhs.eventImage)
    }
}

