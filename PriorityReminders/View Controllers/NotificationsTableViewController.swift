//
//  NotificationsTableViewController.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 6/5/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit
import os.log

class NotificationsTableViewController: UITableViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var notifications = [Notification]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let savedSettings = self.loadNotificationSettings() {
            notifications += savedSettings
        } else {
            self.createDefaultNotificationSettings()
        }
        
        tableView.allowsSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source and other methods
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return notifications[section].name
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return notifications.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "NotificationSettingsCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NotificationsTableViewCell else {
            fatalError("The cell is not an instance of a NotificationsTableViewCell")
        }

        // Configure the cell...
        
        let notification = notifications[indexPath.section]
        
//        cell.setNotificationSettingLabel(name: section)
        cell.notificationSettingLabel.text = notification.name

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//
//        super.prepare(for: segue, sender: sender)
//
//        switch segue.identifier ?? "" {
//        case "ShowNotificationSettings":
//            os_log("Showing notification settings.", log: OSLog.default, type: .debug)
//        default:
//            fatalError("Unexpected Segue Identifier: \(String(describing: segue.identifier))")
//        }
//
//    }
    
    func createDefaultNotificationSettings() -> Void {
        let lowestPrioritySetting = Notification(name: "Lowest Priority", frequency: [2 : "Weeks"])
        let mediumPrioritySetting = Notification(name: "Medium Priority", frequency: [1 : "Weeks"])
        let highestPriority = Notification(name: "Highest Priority", frequency: [1 : "Days"])
        
        notifications += [lowestPrioritySetting, mediumPrioritySetting, highestPriority]
    }
    
    private func saveNotificationSettings() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(notifications, toFile: Notification.ArchivingURL.path)
        
        if isSuccessfulSave {
            os_log("Settings successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save settings...", log: OSLog.default, type: .error)
        }
    }
    
    // Use NSKeyedUnarchiver to unarchive the optional Events array from memory with the path specified in the Event class
    
    private func loadNotificationSettings() -> [Notification]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Notification.ArchivingURL.path) as? [Notification]
    }
    

}
