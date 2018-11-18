//
//  ActivityHistoryTableViewController.swift
//  Final Project - Blossom
//
//  Created by Emma Woodburn on 11/17/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//

import UIKit

class ActivityHistoryTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var activities = [Activity]()
    @IBOutlet var tableView: UITableView!
    
    //var newActivity: Activity? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return activities.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityHistoryTableViewCell
        let activity = activities[indexPath.row]
        cell.update(with: activity)
        cell.accessoryType = .disclosureIndicator
        //shows that you can reorder the cells
        cell.showsReorderControl = true
        //return the cell
        return cell
    }
    
    /**
     If the user wants to reorder the cells in the TableView, then this function gets called. The function deletes the cell and inserts it in the user's desired location. Then it updates the tableView.
     
     - Parameter tableView: The tableview
     - Parameter sourceIndexPath: The current index of the cell
     - Parameter destinationIndexPath: The index where the cell will end up
     */
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //switches the place of the cell based on the user
        let activity = activities.remove(at: sourceIndexPath.row)
        activities.insert(activity, at: destinationIndexPath.row)
        //refreshes the tableView
        tableView.reloadData()
    }
    
    /**
     This function deletes a cell in the table.
     
     - Parameter tableView: The tableview
     - Parameter editingStyle: The editing style of the cell
     - Parameter forRowAt: The index of the cell getting deleted
     */
    //this functions allows for deleting a cell in the tableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            activities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier{
            if identifier == "LogNewActivitySegue"{
                print("segue to log new acitivty view controller")
            }
        }
    }
    
    @IBAction func unwindToActivityHistoryTableViewController(segue: UIStoryboardSegue){
        if let identifier = segue.identifier{
            if identifier == "SaveUnwindSegue"{
                if let addActivityVC = segue.source as? LogNewActivityViewController{
                    if let currActivity = addActivityVC.newActivity{
                        activities.append(currActivity)
                        tableView.reloadData()
                    }
                }
            }
            if identifier == "CancelSegue"{
                print("cancelled")
            }
        }
    }
    
    /**
     If a user wants to edit/stop editting cells in the tableview, then this function gets called.
     
     - Parameter sender: The edit bar button that gets clicked
     */
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        let newEditing = !tableView.isEditing
        tableView.setEditing(newEditing, animated: true)
        //
    }


}
