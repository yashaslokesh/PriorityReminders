//
//  EventViewController.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 5/27/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit
import os.log

class EventViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    //MARK: Properties
    
    @IBOutlet weak var saveEventButton: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var eventNameField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextView!
    
    var event : Event?
    
    // Date Picker Text Fields
    
    @IBOutlet weak var startDate_DatePickerField: UITextField!
    @IBOutlet weak var startDate_TimePickerField: UITextField!
    @IBOutlet weak var endDate_DatePickerField: UITextField!
    @IBOutlet weak var endDate_TimePickerField: UITextField!
    
    
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
        
//        let dateFormatter = DateFormatter()
        
        // ?? asks if a UITextField.text has a value, and if it does, it returns that value. If it does not, it returns the String value placed after the ??
        
        let name : String = eventNameField.text ?? ""
        let startDate : Date = startDate_DatePicker.date
        let endDate : Date = endDate_DatePicker.date
        let eventDescription : String = descriptionTextField.text ?? ""
        let priority : Int = 0
        
        event = Event(name: name, startDate: startDate, endDate: endDate, description: eventDescription, priority: priority)
        
        print("Successfully saved")
    }
    
    //MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let startDatePicker = UIDatePicker()
        startDatePicker.datePickerMode = .date
        self.startDate_DatePickerField.inputView = startDatePicker
        
        let startTimePicker = UIDatePicker()
        startTimePicker.datePickerMode = .time
        self.startDate_TimePickerField.inputView = startTimePicker
        
        let endDatePicker = UIDatePicker()
        endDatePicker.datePickerMode = .date
        self.endDate_DatePickerField.inputView = endDatePicker
        
        let endTimePicker = UIDatePicker()
        endTimePicker.datePickerMode = .time
        self.endDate_TimePickerField.inputView = endTimePicker
        
        // Set delegate for name field, handle user input using this delegate
        eventNameField.delegate = self
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        
        // If the event is non-nil (it exists already), then populate view with already-set properties, for the purpose of editing the event entry
        
        if let event = event {
            eventNameField.text = event.eventName
            startDate_DatePicker.date = event.eventStartDate
            endDate_DatePicker.date = event.eventEndDate
            descriptionTextField.text = event.eventDescription
            
        }
        
        // Enable save button if text field has valid string
        updateSaveButton()
    }
    
    //MARK: UITextViewDelegates
    
    
    
    //MARK: UITextFieldDelegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveEventButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        eventNameField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButton()
        navigationItem.title = textField.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    
    private func updateSaveButton() {
        
        //Disable save button is the name field is empty
        let text : String = eventNameField.text ?? ""
        saveEventButton.isEnabled = !text.isEmpty
        
    }


}

