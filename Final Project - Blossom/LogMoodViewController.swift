//
//  LogMoodViewController.swift
//  Final Project - Blossom
//
//  Created by Ariana Hibbard on 11/23/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//

import UIKit

class LogMoodViewController: UIViewController, UITextViewDelegate {
    // create context to save new mood to core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let dateFormatter = DateFormatter()
    
    // the new mood that will be stored
    var newMood: Mood? = nil
    var currentMood: Moods? = nil
    var personalNotesString: String? = nil
    
    @IBOutlet weak var datePicker: UIDatePicker!
    // this text view is the delegate text view for UITextViewDelegate
    @IBOutlet weak var personalNotesTextView: UITextView!
    @IBOutlet weak var currentMoodLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        personalNotesTextView.text = "Enter your thoughts here:\nSome potential reflection questions:\nWhat happened today?\nDid you have positive or negative interactions?\nWhat went well?\nWhat could have gone better?"
        personalNotesTextView.textColor = .lightGray
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        print("date picker changed")
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: datePicker.date)
        print(strDate)

    }
    @IBAction func veryBadButtonPressed(_ sender: UIButton) {
        print("very bad button pressed")
        currentMood = .very_bad
        updateCurrentMoodLabel(currentMood: currentMood)
    }
    
    
    @IBAction func badButtonPressed(_ sender: UIButton) {
        print("bad button pressed")
        currentMood = .bad
        updateCurrentMoodLabel(currentMood: currentMood)
    }
    
    @IBAction func moderateButtonPressed(_ sender: UIButton) {
        print("moderate button pressed")
        currentMood = .moderate
        updateCurrentMoodLabel(currentMood: currentMood)
    }
    
    
    @IBAction func goodButtonPressed(_ sender: UIButton) {
        print("good button pressed")
        currentMood = .good
        updateCurrentMoodLabel(currentMood: currentMood)
    }
    
    
    @IBAction func veryGoodButtonPressed(_ sender: UIButton) {
        print("very good button pressed")
        currentMood = .very_good
        updateCurrentMoodLabel(currentMood: currentMood)
    }
    
    func updateCurrentMoodLabel(currentMood: Moods?) {
        if let mood = currentMood {
            currentMoodLabel.text = mood.rawValue
        }
    }
    
     // MARK: - UITextViewDelegate functions
    //implements the UITextViewDelegate functionality
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .black
        print("text view did being editing")
    }
    
    //not currently working
    func textViewDidEndEditing(_ textView: UITextView) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SaveMoodUnwindSegue" {
            print("preparing SaveMoodUnwindSegue")
            if let mood = currentMood {
                var userMood = Mood(context: context)
                userMood.moodString = mood.rawValue
                //userMood.moodEmoji = 
                if personalNotesTextView.hasText {
                    userMood.personalNotes = personalNotesTextView.text
                } else {
                    userMood.personalNotes = nil
                }
                
                dateFormatter.dateStyle = DateFormatter.Style.short
                dateFormatter.timeStyle = DateFormatter.Style.short
                
                let date = datePicker.date
                userMood.dateLogged = date as NSDate
                self.newMood = userMood
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "SaveMoodUnwindSegue" {
            guard let _ = currentMood else {
                print("need to log a mood")
                return false
            }
            return true
        }
        return true
    }

}
