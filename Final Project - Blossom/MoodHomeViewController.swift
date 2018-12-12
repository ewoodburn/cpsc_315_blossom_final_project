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
    
    @IBOutlet var labels: [UILabel]!


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
        
        
        let cal = Calendar.current
        var date = cal.startOfDay(for: Date())
        var days = [Int]()
        var weekdays = [Int]()
        for i in 1...7 {
            let day = cal.component(.day, from: date)
            let month = cal.component(.month, from: date)
            let year = cal.component(.year, from: date)
            let weekDayNum: Int = cal.component(.weekday, from: date)
            weekdays.append(weekDayNum)
            print("DATE: ")
            print("\(month)/\(day)/\(year)")
            days.append(day)
            date = cal.date(byAdding: .day, value: -1, to: date)!
        }
        print("")
        print("DAYS: \(days)")
        print("current weekday: \(cal.component(.weekday, from: date))")
        print("")
        
        var daysArray = ["Sun", "Mon", "Tues", "Wed", "Thu", "Fri", "Sat"]
        
        //let weekDayNum: Int = cal.component(.weekday, from: date)
        for i in 0..<weekdays.count {
            labels[i].text = daysArray[weekdays[i]-1]
        }
        var currDay = ""
        /*switch weekDayNum {
        case 1:
            currDay = daysArray[0]
            labels[0].text = currDay
        case 2:
            currDay = daysArray[1]
        case 3:
            currDay = daysArray[2]
        case 4:
            currDay = daysArray[3]
        case 5:
            currDay = daysArray[4]
        case 6:
            currDay = daysArray[5]
        default:
            currDay = daysArray[6]
        }*/
        
        print("CURR DAY: \(currDay)")
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
