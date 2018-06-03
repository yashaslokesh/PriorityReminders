//
//  MenuViewController.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 6/2/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuTable: UITableView!
    
    let menuOptions : [String] = ["Settings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        menuTable.delegate = self
        menuTable.dataSource = self
        
//        menuTable.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: UITableViewDataSource methods
    
    // Return number of sections (self-explanatory)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Return number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    // Configure the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menuCellIdentifier = "MenuTableCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: menuCellIdentifier, for: indexPath) as? MenuTableViewCell else {
            fatalError("The menu cell is not an instance of MenuTableViewCell")
        }
        
        let menuOption = menuOptions[indexPath.row]
        
        cell.menuOptionLabel.text = menuOption
        
        return cell
        
    }
    
}
