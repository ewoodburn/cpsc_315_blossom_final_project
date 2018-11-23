//
//  Mood+CoreDataProperties.swift
//  Final Project - Blossom
//
//  Created by Ariana Hibbard on 11/23/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//
//

import Foundation
import CoreData


extension Mood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mood> {
        return NSFetchRequest<Mood>(entityName: "Mood")
    }

    @NSManaged public var moodEmoji: String?
    @NSManaged public var moodString: String?
    @NSManaged public var personalNotes: String?
    @NSManaged public var dateLogged: NSDate?

}
