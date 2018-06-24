//
//  EventTableViewController.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 5/28/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit
import UserNotifications
import os.log

class EventMasterViewController: UITableViewController, EventTableViewCellDelegate {
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add edit button
//        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        // If events from previous openings of the app are available, then add them to a local constant savedEvents which is then added to the current array of Events
        
        if let savedEvents = self.loadEventsToArray() {
            events += savedEvents
        } else {
            createSampleEvents()
        }
        
        events = self.sortArray(array: events)
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
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
        
        let percentage : Double = (event.percentageDone() > 100.0 ? 100.0 : event.percentageDone())
        
        cell.nameLabel.text = event.eventName
        
        if percentage >= 75.0 {
            cell.setLabelsTextColor(color: UIColor.red)
        } else if percentage >= 50.0 {
            cell.setLabelsTextColor(color: UIColor.orange)
        } else {
            cell.setLabelsTextColor(color: UIColor.black)
        }
        
        let daysLeft : Int = event.daysLeft() < 0 ? 0 : event.daysLeft()
        
        cell.accessoryInfoLabel.text = "Days Left"
        cell.accessoryInfoDisplay.setTitle("\(daysLeft)", for: .normal)
        
        cell.delegate = self
        
        return cell
    }
    
    func didTapButton(_ cell: EventTableViewCell) {
        
        let event = events[(self.tableView.indexPath(for: cell)?.row)!]
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM dd yy"
        let startDate : String = dateFormatter.string(from: event.eventStartDate)
        let endDate : String = dateFormatter.string(from: event.eventEndDate)
        let daysLeft : Int = event.daysLeft() < 0 ? 0 : event.daysLeft()
        
        let accessoryLabelText : String = cell.accessoryInfoLabel.text!
        
        cell.accessoryInfoLabel.textChangeTransition(0.5)
        
        switch accessoryLabelText {
        case "Days Left":
//            cell.setAccessoryInfoLabelText(text: "Start Date")
            cell.accessoryInfoLabel.text = "Start Date"
            cell.accessoryInfoDisplay.setTitle(startDate, for: UIControlState.normal)
        case "Start Date":
//            cell.setAccessoryInfoLabelText(text: "End Date")
            cell.accessoryInfoLabel.text = "End Date"
            cell.accessoryInfoDisplay.setTitle(endDate, for: UIControlState.normal)
        case "End Date":
//            cell.setAccessoryInfoLabelText(text: "Days Left")
            cell.accessoryInfoLabel.text = "Days Left"
            cell.accessoryInfoDisplay.setTitle("\(daysLeft)", for: UIControlState.normal)
        default:
            fatalError("Fix the Accessory Info Label")
        }
    }
    
    // MARK: Actions
    
    // Receives an action from the eventViewController (the detail) and accordingly sets up the table scene
    @IBAction func unwindToEventList(sender: UIStoryboardSegue) {
        if let source = sender.source as? EventDetailViewController, let event = source.event {
            
            if let selectedIndex = tableView.indexPathForSelectedRow {
                events[selectedIndex.row] = event
                tableView.reloadRows(at: [selectedIndex], with: .fade)
            } else {
                let indexPath = IndexPath(row: events.count, section: 0)
                events.append(event)
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            // Sort array
            events = self.sortArray(array: events)
            tableView.reloadData()
            // Save the Events whenever an event is added or modified (or cancel is clicked)
            self.saveEvents()
            
            let content = UNMutableNotificationContent()
            
            content.body = "\(event.eventName) is coming up in \(event.daysLeft()) more days"
            
            let percentage : Double = event.percentageDone()
            
            var timeInterval : Double = 0.0
            
            let defaults = UserDefaults.standard
            
//            defaults.set(2, forKey: "lowestPriorityFrequency")
//            defaults.set(1, forKey: "mediumPriorityFrequency")
//            defaults.set(1, forKey: "highPriorityFrequency")
//            defaults.set("Weeks", forKey: "lowestPriorityUnits")
//            defaults.set("Weeks", forKey: "mediumPriorityUnits")
//            defaults.set("Days", forKey: "highPriorityUnits")
            
            if percentage >= 75.0 {
                let frequency = defaults.integer(forKey: "highPriorityFrequency")
                let units = defaults.string(forKey: "highPriorityUnits")
                timeInterval = self.convertTimeIntervalToSeconds(frequency: frequency, units: units!)
            } else if percentage >= 50.0 {
                let frequency = defaults.integer(forKey: "mediumPriorityFrequency")
                let units = defaults.string(forKey: "mediumPriorityUnits")
                timeInterval = self.convertTimeIntervalToSeconds(frequency: frequency, units: units!)
            } else {
                let frequency = defaults.integer(forKey: "lowestPriorityFrequency")
                let units = defaults.string(forKey: "lowestPriorityUnits")
                timeInterval = self.convertTimeIntervalToSeconds(frequency: frequency, units: units!)
            }
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            
            let request = UNNotificationRequest(identifier: event.eventName, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }
    }
    
    func convertTimeIntervalToSeconds(frequency : Int, units : String) -> Double {
        
        var timeInterval : Double = 0.0
        let freq : Double = Double(frequency)
        
        switch units {
        case "Hours":
            timeInterval = freq * 60 * 60
        case "Days":
            timeInterval = freq * 60 * 60 * 24
        case "Weeks":
            timeInterval = freq * 60 * 60 * 24 * 7
        case "Months":
            timeInterval = freq * 60 * 60 * 24 * 30.44
        default:
            fatalError("Unsupported time units")
        }
        
        return timeInterval
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the event that was chosen to be deleted from the events array
            events.remove(at: indexPath.row)
            
            // Sort array
            events = self.sortArray(array: events)
            tableView.reloadData()
            // Save Events array once the delete command goes through and an event is removed
            self.saveEvents()
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
        case "AddEvent":
            os_log("Adding a new event.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let eventViewController = segue.destination as? EventDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedEventCell = sender as? EventTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedEventCell) else {
                fatalError("Selected event is not being displayed on table")
            }
            
            let selectedEvent = events[indexPath.row]
            eventViewController.event = selectedEvent
            
        default:
            fatalError("Unexpected Segue Identifier: \(String(describing: segue.identifier))")
        }
    }
 
    
    // MARK: Private Methods

    // Create sample events to populate the screen, when the app is first loaded
    
    private func createSampleEvents() {
        guard let eventOne = Event(name: "Be Awesome", startDate: Date(), endDate: Date(timeInterval: 315532800, since: Date()), description: "Don't forget to be awesome everyday!") else {
            fatalError("eventOne Creation failure")
        }
        
        guard let eventTwo = Event(name: "Eat Breakfast", startDate: Date(), endDate: Date(timeInterval: 315532800, since: Date()), description: "Eat breakfast everyday so you have energy in the mornings!") else {
            fatalError("eventTwo Creation failure")
        }
        
        guard let eventThree = Event(name: "Change the World", startDate: Date(), endDate: Date(timeInterval: 315532800, since: Date()), description: "Go out and change the world, in any small way that you can...") else {
            fatalError("eventThree Creation Failure")
        }

        events += [eventOne, eventTwo, eventThree]
    }
    
    // Use NSKeyedArchiver to archive the Events array to memory with the path specified in the Event class
    
    private func saveEvents() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: Event.ArchivingURL.path)
        
        if isSuccessfulSave {
            os_log("Events successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save events...", log: OSLog.default, type: .error)
        }
    }
    
    // Use NSKeyedUnarchiver to unarchive the optional Events array from memory with the path specified in the Event class
    
    private func loadEventsToArray() -> [Event]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Event.ArchivingURL.path) as? [Event]
    }
    
    // Sorts array in descending order so that events with a higher percentage done are at the top, then reloads the table view so that the table view complies
    func sortArray(array : [Event]) -> [Event] {
        return array.sorted(by: { $0.percentageDone() > $1.percentageDone()})
    }
}
