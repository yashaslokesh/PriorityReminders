//
//  ViewController.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 5/27/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    
    @IBOutlet weak var eventNameField: UITextField!
    
    
    //MARK: Actions
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        eventNameField.delegate = self
    }
    
    //MARK: UITextFieldDelegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        eventNameField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

