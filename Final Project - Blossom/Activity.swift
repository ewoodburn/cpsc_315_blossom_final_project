//
//  Activity.swift
//  Final Project - Blossom
//
//  Created by Emma Woodburn on 11/17/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//

import Foundation

struct Activity{
    var activityType: String
    //do we want this as an int or a string?
    var timeSpent: String
    //need to change this into a Date
    var date: String
    var personalNotes: String
    
    init(activityType: String, timeSpent: String, date: String, personalNotes: String) {
        self.activityType = activityType
        self.timeSpent = timeSpent
        self.date = date
        self.personalNotes = personalNotes
    }
}
