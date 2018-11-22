//
//  ActivityHistoryTableViewCell.swift
//  Final Project - Blossom
//
//  Created by Emma Woodburn on 11/17/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//

import UIKit

class ActivityHistoryTableViewCell: UITableViewCell {
    //setting up the connections to the UI components
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with activity: Activity) {
        typeLabel.text = activity.activityType
        timeLabel.text = activity.timeSpent
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let currDate = activity.date as! Date  
        let dateString = dateFormatter.string(from: currDate)
        dateLabel.text = dateString
    }

}
