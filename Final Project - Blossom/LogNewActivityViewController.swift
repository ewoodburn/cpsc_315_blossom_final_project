//
//  LogNewActivityViewController.swift
//  Final Project - Blossom
//
//  Created by Emma Woodburn on 11/17/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//

import UIKit

class LogNewActivityViewController: UIViewController {
    //setting up the connections to the UI elements
    @IBOutlet var activityTypeLabel: UILabel!
    @IBOutlet var activityTypeTextField: UITextField!
    @IBOutlet var timeSpentLabel: UILabel!
    @IBOutlet var timeSpentTextField: UITextField!
    @IBOutlet var dateLoggedLabel: UILabel!
    @IBOutlet var dateLoggedTextField: UITextField!
    @IBOutlet var personalNotesLabel: UILabel!
    @IBOutlet var personalNotesTextField: UITextField!
    
    //the new activity to be stored
    var newActivity: Activity? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier{
            if identifier == "SaveUnwindSegue"{
                if let activityType = activityTypeTextField.text, let timeSpent = timeSpentTextField.text, let date = dateLoggedTextField.text, let personalNotes = personalNotesTextField.text{
                    var activity = Activity(activityType: activityType, timeSpent: timeSpent, date: date, personalNotes: personalNotes)
                    newActivity = activity
                    
                }
            }
        }
    }


}
