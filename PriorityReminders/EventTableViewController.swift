//
//  EventTableViewController.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 5/28/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {

    var events = [Event]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        createSampleEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // The sections of cells, in this case, only one (only one section of Events)
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the table, by getting the number of events in the events array
        return events.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let eventCellIdentifier = "EventTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: eventCellIdentifier, for: indexPath) as? EventTableViewCell else {
            fatalError("The cell is not an instance of EventTableViewCell")
        }
        
        //Configure the cell...
        
        // Configures the cell with the appropriate event
        
        let event = events[indexPath.row]
        
        cell.nameLabel.text = event.eventName
        cell.endDateLabel.text = event.eventEndDate.description
        cell.priorityLabel.text = event.eventPriority.description

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    private func createSampleEvents() {
        guard let eventOne = Event(name: "Be Awesome", startDate: Date(), endDate: Date(timeInterval: 315532800, since: Date()), description: "Don't forget to be awesome everyday!", priority: 0) else {
            fatalError("eventOne Creation failure")
        }
        
        guard let eventTwo = Event(name: "Eat Breakfast", startDate: Date(), endDate: Date(timeInterval: 315532800, since: Date()), description: "Eat breakfast everyday so you have energy in the mornings!", priority: 0) else {
            fatalError("eventTwo Creation failure")
        }
        
        guard let eventThree = Event(name: "Change the World", startDate: Date(), endDate: Date(timeInterval: 315532800, since: Date()), description: "Go out and change the world, in any small way that you can...", priority: 0) else {
            fatalError("eventThree Creation Failure")
        }

        events += [eventOne, eventTwo, eventThree]
        
    }
    
}
