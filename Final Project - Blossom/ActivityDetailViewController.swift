//
//  ActivityDetailViewController.swift
//  Final Project - Blossom
//
//  Created by Emma Woodburn on 12/2/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {
    var activity: Activity? = nil
    
    @IBOutlet var activityTypeLabel: UILabel!
    @IBOutlet var dateAndTimeLabel: UILabel!
    @IBOutlet var personalNotesLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedActivity = activity{
            activityTypeLabel.text = selectedActivity.activityType
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            if let date = selectedActivity.date, let time = selectedActivity.timeSpent, let personalNotes = selectedActivity.personalNotes{
                let activityDateString = dateFormatter.string(from: date as Date)
                dateAndTimeLabel.text = "On \(activityDateString) for \(time)"
                personalNotesLabel.text = personalNotes


            }
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
