//
//  SettingsTableViewController.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 6/3/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit

class SettingsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let settingsOptions = ["Notifications"]
    private let cellId = "id"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        collectionView.backgroundColor = UIColor(white: 0.8, alpha: 1)
        navigationItem.title = "Settings"
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(SettingsViewCell.self, forCellWithReuseIdentifier: cellId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsViewCell
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}
