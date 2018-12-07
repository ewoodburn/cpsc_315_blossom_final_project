//
//  MoodHistoryTableViewCell.swift
//  Final Project - Blossom
//
//  Created by Ariana Hibbard on 11/23/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//  This is the custom cell used to display a mood in the Mood Table View.

import UIKit

class MoodHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var dateLoggedLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     Is invoked when the edit bar button is pressed. It sets or ends editing mode to make edits to the table view.
     - Parameter : _ sender: The UIBarButtonItem that invokes the editing changes
     - Returns: nothing
     */
    func update(with mood: Mood) {
        moodLabel.text = mood.moodString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let currDate = mood.dateLogged as! Date
        let dateString = dateFormatter.string(from: currDate)
        dateLoggedLabel.text = dateString
    }

}
