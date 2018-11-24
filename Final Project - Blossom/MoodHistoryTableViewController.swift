//
//  MoodHistoryTableViewController.swift
//  Final Project - Blossom
//
//  Created by Ariana Hibbard on 11/23/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//

import UIKit
import CoreData

class MoodHistoryTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var moods:[Mood] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadMoods()
    }
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        print("edit bar button pressed")
        let editing = !tableView.isEditing
        tableView.setEditing(editing, animated: true)
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return moods.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoodHistoryCell", for: indexPath) as! MoodHistoryTableViewCell
        let mood = moods[indexPath.row]
        cell.update(with: mood)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //switches the place of the cell based on the user
        let mood = moods.remove(at: sourceIndexPath.row)
        moods.insert(mood, at: destinationIndexPath.row)
        //refreshes the tableView
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(moods[indexPath.row])
            moods.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveMoods()
        }
    }
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
    
    func saveMoods() {
        do{
            try context.save()
        }
        catch{
            print("error saving activites")
        }
        
        self.tableView.reloadData()
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
