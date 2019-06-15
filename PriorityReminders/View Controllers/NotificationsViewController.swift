//
//  NotificationsTableViewController.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 6/5/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit
import os.log

class NotificationsViewController: UICollectionViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var notifications = [Any]()
    let cellId = "id"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        collectionView.allowsSelection = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? NotificationsViewCell else {
            fatalError("The cell could not be reused or is not an instance of NotificationsViewCell")
        }
        
        return cell
    }
    
    

}


