//
//  ActivityLogViewController.swift
//  Final Project - Blossom
//  Activity icon provided by the following website:
//  https://www.flaticon.com/free-icon/bike_1034939#term=activities&page=1&position=33
//  Created by Emma Woodburn on 11/17/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//

import UIKit
import CoreData


class ActivityLogViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var activites: [Activity] = []
    
    let healthKit = HealthKitData()
    //setting up the connections to the UI
    @IBOutlet var activityLogLabel: UILabel!
    @IBOutlet var daysLoggedLabel: UILabel!
    
    //this will need to be changed
    @IBOutlet var calendarLabel: UILabel!
    @IBOutlet var stepCountLabel: UILabel!
    @IBOutlet var hoursLoggedLabel: UILabel!
    
    var steps: Double = 0
    var minutes: Double = 0
    //var storedActivity: Activity? = nil

    override func viewDidLoad() {

        super.viewDidLoad()
        loadActivities()
        updateUI()
        
        print(activites.count)

        // Do any additional setup after loading the view.
        healthKit.activateHealthKit()
        healthKit.retrieveStepCount {
            (steps) in
            self.steps = steps
            self.updateUI()
        }
        healthKit.retrieveMindfulnessMinutes {
            (minutes) in
            self.minutes = minutes
            self.updateUI()
        }
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
            if identifier == "ViewActivityHistorySegue"{
                print("segue to activity history view controller")
            }
            
        }
    }
    
    func updateUI() {
        print("steps: \(steps)")
        stepCountLabel.text = "🏃‍♀️ Step Count: \(steps) steps"
        print("days: \(minutes)")
        hoursLoggedLabel.text = "🧘‍♀️ Total Mindfulness Minutes Logged: \(minutes) minutes"
        daysLoggedLabel.text = "🗓 Days Logged: \(activites.count) days"
    }
    
    func loadActivities() {
        let request: NSFetchRequest<Activity> = Activity.fetchRequest()
        
        do{
            activites = try context.fetch(request)
        }
        catch{
            print("Error fetching activities")
        }
    }
    



}
