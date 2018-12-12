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
    
    var weekMoods:[String] = ["-","-","-","-","-","-","-"]
    
    var lastStreakEndDate: NSDate!
    var streakTotal: Int!
    
    let dateFormatter = DateFormatter()
    @IBOutlet var labels: [UILabel]!
    
    @IBOutlet var emojiLabels: [UILabel]!
    
    var daysArray = ["Sun", "Mon", "Tues", "Wed", "Thu", "Fri", "Sat"]

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
        updateEmojisView()
        updateWeekLabels()

   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadMoods()
        updateEmojisView()
        updateWeekLabels()
    }
    
    func updateWeekLabels() {
        print("UPDATING THE WEEK LABELS")
        let cal = Calendar.current
        var date = cal.startOfDay(for: Date())
        var weekdays = [Int]()
        
        for i in 1...7 {
            let weekDayNum: Int = cal.component(.weekday, from: date)
            weekdays.append(weekDayNum)
            date = cal.date(byAdding: .day, value: -1, to: date)!
        }
        
        for i in 0..<weekdays.count {
            labels[i].text = daysArray[weekdays[i]-1]
        }
    }
    
    func updateEmojisView() {
        print("UPDATING THE EMOJIS VIEW")
        let cal = Calendar.current
        var date = cal.startOfDay(for: Date())
        var weekdays = [Int]()
        
        var dateArray = [Date]()
        
        var dateStringArray = [String]()
        
        for i in 1...7 {
            let day = cal.component(.day, from: date)
            let month = cal.component(.month, from: date)
            let year = cal.component(.year, from: date)
            
            var dateString:String
            
            if day < 10 {
                dateString = "\(year)-\(month)-0\(day)"
            } else {
                dateString = "\(year)-\(month)-\(day)"
            }
            
            dateStringArray.append(dateString)
            print("datestring: \(dateString)")

            print("calling checkMoodArray")
            if let newEmoji = checkMoodArray(dateString: dateString) {
                // update the right labels
                emojiLabels[i-1].text = newEmoji
                print("i-1: \(i-1)")
                print("NEW EMOJI: \(newEmoji)")
            } else {
                emojiLabels[i-1].text = "❓"
            }
            date = cal.date(byAdding: .day, value: -1, to: date)!
        }
    }
    
    func checkMoodArray(dateString: String) -> String? {
        for mood in moods {
            if let currDate = mood.dateLogged as? Date {
        
                //var currWeekday = cal.component(.weekday, from: date)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let moodDateString = dateFormatter.string(from: currDate)
                
                
                print("here is the current date we're on: \(moodDateString)")
                
                if dateString == moodDateString{
                    print("they are the same")
                    print("dateString: \(dateString)")
                    if let currMoodWhenMatching = mood.moodEmoji {
                        print("currModdWhenMatching: \(currMoodWhenMatching)")
                        return currMoodWhenMatching
                    }
                    
                }
            }
            
            
        }
        return nil
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
