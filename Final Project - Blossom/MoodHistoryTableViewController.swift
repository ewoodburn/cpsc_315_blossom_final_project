//
//  MoodHistoryTableViewController.swift
//  Final Project - Blossom
//  This file implements the table view for a user's mood history. It allows the user to view all the moods they have logged over time in the form of a table.
//  Created by Ariana Hibbard on 11/23/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//

import UIKit
import CoreData

class MoodHistoryTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // this allows the app to store data in the database using CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var moods:[Mood] = []
    var moodDates:[Date] = []
    
    var lastStreakEndDate: NSDate!
    var streakTotal: Int!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadMoods()
        
        var num = moods.count
        //loading the array of dates
        for i in moods {
            if let currDate = i.dateLogged{
                if let newDate = currDate as Date!{
                    moodDates.append(newDate)
                    
                    
                }
            }
        }
        //sorted from most recent date to least recent date
        var ready = moodDates.sorted(by: { $0.compare($1) == .orderedDescending })
        print("")
        print("sorted dates: \(ready)")
        print("")

        
        if checkIfMoodIsSad() == true{
            var alertController = UIAlertController(title: "We noticed something", message: "You've logged a sad mood for two weeks straight. We recommend heading over to the Resources tab for information on important mental health resources.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    /**
     Is invoked when the edit bar button is pressed. It sets or ends editing mode to make edits to the table view.
     - Parameter : _ sender: The UIBarButtonItem that invokes the editing changes
     - Returns: nothing
     */
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        print("edit bar button pressed")
        let editing = !tableView.isEditing
        tableView.setEditing(editing, animated: true)
    }
    // MARK: - Table view data source
    /**
     Sets the number of sections that should be in a table view.
     - Parameter : in tableView: the UITableView that should be formatted
     - Returns: Int
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     Sets the number of rows that should be in each section for a table.
     - Parameter : in tableView: the UITableView that should be formatted
     - Parameter : numberOfRowsInSection section: whichever section is being formatted
     - Returns: Int
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if the section is 0, the number of rows should be the number of moods in the array
        // else, there should be no other sections or rows
        if section == 0 {
            return moods.count
        }
        return 0
    }
    
    /**
    Dequeues a reusable cell that can be formatted to display the current mood information. The resuable cell is the MoodHistoryCell in UIStoryboard.
     - Parameter : _ tableView: UITableView to be formatted.
     - Parameter : cellForRowAt indexPath: describes the row containing the cell being formatted
     - Returns: UITableViewCell
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoodHistoryCell", for: indexPath) as! MoodHistoryTableViewCell
        let mood = moods[indexPath.row]
        cell.update(with: mood)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    /**
     Allows a user to reorder the cells in the table view when in editing mode.
     - Parameter : _ tableView: the UITableView that should be formatted
     - Parameter : moveRowAt sourceIndexPath: IndexPath describing the row's original location
     - Parameter : to destinationIndexPath: IndexPath describing where the cell will be moved
     - Returns: nothing
     */
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //switches the place of the cell based on the user
        let mood = moods.remove(at: sourceIndexPath.row)
        moods.insert(mood, at: destinationIndexPath.row)
        //refreshes the tableView
        tableView.reloadData()
    }
    
    /**
     Allows a user to delete a row in the table.
     - Parameter : in tableView: the UITableView that should be formatted
     - Parameter : commit editingStyle: contains the edit that should be made to the table
     - Returns: Nothing
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(moods[indexPath.row])
            moods.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveMoods()
        }
    }
    
    /**
     Unwind segue function to unwind a view back to the Mood History Table View
     - Parameter : _ segue: a UIStoryboardSegue that contains the identifier to identify segue
     - Returns: Nothing
     */
    @IBAction func unwindSegueToMoodHistoryTableVC(_ segue: UIStoryboardSegue) {
        print("unwindToMoodHistoryTableVC segue performed")
        if segue.identifier == "SaveMoodUnwindSegue" {
            print("SaveMoodUnwindSegue called")
            if let addMoodVC = segue.source as? LogMoodViewController {
                if let mood = addMoodVC.newMood {
                    moods.append(mood)
                    print(moods)
                    saveMoods()
                    tableView.reloadData()
                }
            }
        }
    }
    
    /**
    Loads the moods from the database.
     - Parameter : Nothing
     - Returns: Nothing
     */
    func loadMoods() {
        let request: NSFetchRequest<Mood> = Mood.fetchRequest()
        
        do{
            moods = try context.fetch(request)
        }
        catch{
            print("Error fetching activities")
        }
        tableView.reloadData()
    }
    
    /**
    Saves the moods to the database.
     - Parameter : Nothing
     - Returns: Nothing
     */
    func saveMoods() {
        do{
            try context.save()
        }
        catch{
            print("error saving activites")
        }
        
        self.tableView.reloadData()
    }

    func checkIfMoodIsSad() -> Bool{
        return true
    }
    
    /*
    func consecutiveDatesCheck() -> Int {
        

        
    }
 */
 

}
