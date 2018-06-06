//
//  Notification.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 6/5/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import Foundation
import os.log
import UserNotifications

class Notification : NSCoding {
    
    var name : String
    var reminderFrequency : [Int : String]
    
    init(name : String, frequency : [Int : String]) {
        self.name = name
        self.reminderFrequency = frequency
    }
    
    // an initializer to test the decoding of the name object, at a minimum, and then decodes the rest of the properties
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: NotificationProperties.notificationName) as? String else {
            os_log("Unable to decode an Event object's name.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let frequency = aDecoder.decodeObject(forKey: NotificationProperties.reminderFrequency) as? [Int : String]
        
        self.init(name: name, frequency: frequency!)
        
    }
    
    //MARK: Types of data used in the application (for each Event)
    
    struct NotificationProperties {
        static let notificationName = "name"
        static let reminderFrequency = "reminder"
    }
    
    //MARK: Local path for archiving Event instances
    
    static let FilesDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchivingURL = FilesDirectory.appendingPathComponent("notifications")
    
    //MARK: NSCoding
    // Used to encode the events and store them
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: NotificationProperties.notificationName)
        aCoder.encode(reminderFrequency, forKey: NotificationProperties.reminderFrequency)
    }
    
}
