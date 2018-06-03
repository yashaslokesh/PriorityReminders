//
//  EventViewController.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 5/27/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit
import os.log

class EventDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    //MARK: Properties
    
    @IBOutlet weak var saveEventButton: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var eventNameField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var event : Event?
    
    let dateFormatter : DateFormatter = DateFormatter()
    
    // Date Picker Text Fields
    
    @IBOutlet weak var startDatePickerField: UITextField!
    @IBOutlet weak var endDatePickerField: UITextField!
    
    //MARK: Actions
    
    @IBAction func cancelEvent(_ sender: UIBarButtonItem) {
        
        // Is true if the view controller presenting the detail is the UINavigationController, which occurs when the user presses the add button
        let isPresentingAddEvent = presentingViewController is UINavigationController
        
        if isPresentingAddEvent {
            dismiss(animated: true, completion: nil)
        } else if let mainNavigationController = navigationController {
            mainNavigationController.popViewController(animated: true)
        } else {
            fatalError("The EventViewController is not contained in a UINavigationController")
        }
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveEventButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let fullDateFormatter = DateFormatter()
        fullDateFormatter.dateFormat = "MMMM dd, yyyy"
        
        // ?? asks if a UITextField.text has a value, and if it does, it returns that value. If it does not, it returns the String value placed after the ??
        
        let name : String = eventNameField.text ?? ""
        let startDateString : String = startDatePickerField.text!
        let startDate : Date = fullDateFormatter.date(from: startDateString)!
        
        let endDateString : String = endDatePickerField.text!
        let endDate : Date = fullDateFormatter.date(from: endDateString)!
        let eventDescription : String = descriptionTextView.text ?? ""
        let priority : Int = 0
        
        event = Event(name: name, startDate: startDate, endDate: endDate, description: eventDescription, priority: priority)
        
        print("Successfully saved")
    }
    
    //MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set delegate for all text fields, handle user input using this delegate
        self.eventNameField.delegate = self
        self.startDatePickerField.delegate = self
        self.endDatePickerField.delegate = self
        
        // Set date picker and toolbar as input views
        
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        startDatePickerField.text = dateFormatter.string(from: Date())
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        datePicker.addTarget(self, action: #selector(EventDetailViewController.datePickerChangedValue(_:)), for: UIControlEvents.valueChanged)
        
        let doneButton : UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(EventDetailViewController.doneSelection))
        
        let toolbar : UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        
        startDatePickerField.inputView = datePicker
        endDatePickerField.inputView = datePicker
        
        startDatePickerField.inputAccessoryView = toolbar
        endDatePickerField.inputAccessoryView = toolbar
        descriptionTextView.inputAccessoryView = toolbar
        
        // If the event is non-nil (it exists already), then populate view with already-set properties, for the purpose of editing the event entry
        
        if let event = event {
            eventNameField.text = event.eventName
            
            startDatePickerField.text = dateFormatter.string(from: event.eventStartDate)
            endDatePickerField.text = dateFormatter.string(from: event.eventEndDate)
            
            descriptionTextView.text = event.eventDescription
            
        }
        
        // Enable save button if text field has valid string
        updateSaveButton()
    }
    
    //MARK: Date Picking methods
    
    @objc func datePickerChangedValue(_ sender: UIDatePicker) {
        let date = sender.date
        
        if startDatePickerField.isFirstResponder {
            startDatePickerField.text = dateFormatter.string(from: date)
        } else if endDatePickerField.isFirstResponder {
            endDatePickerField.text = dateFormatter.string(from: date)
        }
    }
    
    @objc func doneSelection(_ sender : UIBarButtonItem) {
        if startDatePickerField.isFirstResponder {
            startDatePickerField.resignFirstResponder()
        } else if endDatePickerField.isFirstResponder {
            endDatePickerField.resignFirstResponder()
        } else if descriptionTextView.isFirstResponder {
            descriptionTextView.resignFirstResponder()
        }
    }
    
    //MARK: UITextViewDelegates
    
    
    
    //MARK: UITextFieldDelegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveEventButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        print("User finished editing event name")
        eventNameField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButton()
        navigationItem.title = eventNameField.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    
    private func updateSaveButton() {
        
        //Disable save button if any mandatory fields are empty
        let nameText : String = eventNameField.text ?? ""
        let endDateText : String = endDatePickerField.text!
        
        saveEventButton.isEnabled = !(nameText.isEmpty || endDateText.isEmpty)
        
    }


}

