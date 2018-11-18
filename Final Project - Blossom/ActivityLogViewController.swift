//
//  ActivityLogViewController.swift
//  Final Project - Blossom
//
//  Created by Emma Woodburn on 11/17/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//

import UIKit

class ActivityLogViewController: UIViewController {
    //setting up the connections to the UI
    @IBOutlet var activityLogLabel: UILabel!
    @IBOutlet var daysLoggedLabel: UILabel!
    
    //this will need to be changed
    @IBOutlet var calendarLabel: UILabel!
    @IBOutlet var stepCountLabel: UILabel!
    @IBOutlet var hoursLoggedLabel: UILabel!
    
    var storedActivity: Activity? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logActivityButtonPressed(_ sender: UIButton){
        print("log activity button pressed")
    }
    
    @IBAction func seeActivityHistoryButtonPressed(_ sender: UIButton){
        print("see activity history button pressed")
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier{
            if identifier == "LogNewActivitySegue"{
                print("segue to log new activity view controller")
            }
            if identifier == "ViewActivityHistorySegue"{
                if let activityHistoryVC = segue.destination as? ActivityHistoryViewController{
                    if let currStoredActivity = storedActivity{
                        activityHistoryVC.newActivity = currStoredActivity
                        print("segue to activity history view controller")

                    }
                }
            }
        }
    }
    
    @IBAction func unwindToActivityLogViewController(segue: UIStoryboardSegue){
        if let identifier = segue.identifier{
            if identifier == "SaveUnwindSegue"{
                if let logActivityVC = segue.source as? LogNewActivityViewController{
                    if let newActivity = logActivityVC.newActivity{
                        storedActivity = newActivity
                    }
                }
                
            }
        }
    }


}
