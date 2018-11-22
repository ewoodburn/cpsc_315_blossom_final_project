//
//  Activity+CoreDataProperties.swift
//  Final Project - Blossom
//
//  Created by Emma Woodburn on 11/21/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var activityType: String?
    @NSManaged public var timeSpent: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var personalNotes: String?

}
