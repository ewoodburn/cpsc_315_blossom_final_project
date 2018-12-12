//
//  MoodHomeViewController.swift
//  Final Project - Blossom
//  Mood icon provided by the following website:
//  https://www.flaticon.com/free-icon/smile_1243539#term=moods&page=1&position=3
//  Created by Ariana Hibbard on 11/23/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//

import UIKit
import CoreData

class MoodHomeViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var moods:[Mood] = []

    var moodDates:[Date] = []
    
    var lastStreakEndDate: NSDate!
    var streakTotal: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadMoods()
        
        consecutiveDatesCheck()
        
        
        if checkIfMoodIsSad() == true{
            var alertController = UIAlertController(title: "We noticed something", message: "You've logged a sad mood for two weeks or more. We recommend heading over to the Resources tab for information on important mental health resources.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    

    @IBAction func moodHistoryButtonPressed(_ sender: UIButton) {
        print("mood history button pressed")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func consecutiveDatesCheck() {
        var num = moods.count
        //loading the array of dates when the mood was bad or very bad
        for i in moods {
            //print("mood: \(i.moodEmoji)")
            if i.moodString == "🙁 Bad" || i.moodString == "😔 Very bad"{
                if let currDate = i.dateLogged{
                    if let newDate = currDate as Date!{
                        moodDates.append(newDate)
                    }
                }
            }
            
        }
        //sorted from most recent date to least recent date
        var ready = moodDates.sorted(by: { $0.compare($1) == .orderedDescending })
        print("")
        print("sorted dates: \(ready)")
        print("")
        
    }
    
    func checkIfMoodIsSad() -> Bool{
        if moodDates.count >= 14{
            return true
        } else{
            return false
        }
    }
    
    func loadMoods() {
        let request: NSFetchRequest<Mood> = Mood.fetchRequest()
        
        do{
            moods = try context.fetch(request)
        }
        catch{
            print("Error fetching activities")
        }
        //tableView.reloadData()
    }

}
