//
//  LogNewActivityViewController.swift
//  Final Project - Blossom
//
//  Created by Emma Woodburn on 11/17/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//

import UIKit
import CoreData

class LogNewActivityViewController: UIViewController {
    //setting up the connections to the UI elements
    @IBOutlet var activityTypeLabel: UILabel!
    @IBOutlet var activityTypeTextField: UITextField!
    @IBOutlet var timeSpentLabel: UILabel!
    @IBOutlet var timeSpentTextField: UITextField!
    @IBOutlet var dateLoggedLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var personalNotesLabel: UILabel!
    @IBOutlet var personalNotesTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let dateFormatter = DateFormatter()
    
    //the new activity to be stored
    var newActivity: Activity? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func dateChanged(_ sender: Any) {
        print("date picker changed")
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: datePicker.date)
        print(strDate)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier{
            if identifier == "SaveUnwindSegue"{
                if let activityType = activityTypeTextField.text, let timeSpent = timeSpentTextField.text,  let personalNotes = personalNotesTextField.text{
                    // date formatting
                    dateFormatter.dateStyle = DateFormatter.Style.short
                    dateFormatter.timeStyle = DateFormatter.Style.short
                    
                    let date = datePicker.date
                    var userActivity = Activity(context: context)
                    userActivity.date = date as NSDate
                    userActivity.activityType = activityType
                    userActivity.timeSpent = timeSpent
                    userActivity.personalNotes = personalNotes
                    //userActivity.
                    self.newActivity = userActivity
                }
            }
        }
    }
    
    /**
     Checks to see if the Date is formatted correctly.
     
     - Parameter dateString: The String representation of the Date
     - Returns: True if the Date is formatted correctly. False otherwise.
     */
    func isDateFormatted(dateString: String) -> Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        if let date = dateFormatter.date(from: dateString){
            return true
        }
        return false
    }


}
