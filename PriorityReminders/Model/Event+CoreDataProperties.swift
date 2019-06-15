//
//  Event+CoreDataProperties.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 6/15/19.
//  Copyright © 2019 Yashas Lokesh. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var descr: String
    @NSManaged public var endDate: NSDate
    @NSManaged public var imageName: String
    @NSManaged public var name: String
    @NSManaged public var startDate: NSDate

}
