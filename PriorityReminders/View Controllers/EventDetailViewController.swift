//
//  EventViewController.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 5/27/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit
import os.log
import UserNotifications

class EventDetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    //MARK: Properties
    
    private func setup() {
        
        imageView = {
            let view = UIImageView()
            view.isUserInteractionEnabled = true
            view.contentMode = .scaleAspectFill
            return view
        }()
        
        let datePicker : UIDatePicker = {
            let picker = UIDatePicker()
            picker.datePickerMode = .date
            picker.addTarget(self, action: #selector(datePickerChangedValue(_:)), for: .valueChanged)
            return picker
        }()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneSelection(_:)))
        
        let toolbar : UIToolbar = {
            let tb = UIToolbar()
            tb.barStyle = .default
            tb.sizeToFit()
            tb.setItems([doneButton], animated: true)
            tb.isUserInteractionEnabled = true
            return tb
        }()
        
        startDateField = {
            let field = UITextField()
            field.inputView = datePicker
            field.inputAccessoryView = toolbar
            field.delegate = self
            return field
        }()
        
        endDateField = {
            let field = UITextField()
            field.inputView = datePicker
            field.inputAccessoryView = toolbar
            field.delegate = self
            return field
        }()
        
        nameField = {
            let field = UITextField()
            field.delegate = self
            return field
        }()
        
        descriptionTextView = {
            let view = UITextView()
            view.inputAccessoryView = toolbar
            view.delegate = self
            ()
        }()
        
    }
    
    let saveEventButton = UIBarButtonItem()
    var scrollView : UIScrollView?
    var nameField : UITextField?
    var descriptionTextView : UITextView?
    var imageView : UIImageView?
    
    var startDateField : UITextField?
    var endDateField : UITextField?
    
//    let startDateField: UITextField = {
//        let field = UITextField()
//        field.inputView = datePicker
//        field.inputAccessoryView = toolbar
//        return field
//    }()
    
//    @IBOutlet weak var saveEventButton: UIBarButtonItem!
//    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var eventNameField: UITextField!
//    @IBOutlet weak var descriptionTextView: UITextView!
//    @IBOutlet weak var eventImage: UIImageView!
    
    var event : Event?
    
//    let dateFormatter : DateFormatter = DateFormatter()
    
    // Date Picker Text Fields
//
//    @IBOutlet weak var startDatePickerField: UITextField!
//    @IBOutlet weak var endDatePickerField: UITextField!
    
    // Date Picker
    
    //MARK: Storybard Actions
    
    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        checkForAndResignFirstResponder()
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cancelEvent(_ sender: UIBarButtonItem) {
        
//         Is true if the view controller presenting the detail is the UITabBarController, which occurs when the user presses the add button
        let isPresentingAddEvent = presentingViewController is UITabBarController

        print("Cancel request Received")

        if isPresentingAddEvent {
            // If adding event

            print("Cancelling add event")
            self.dismiss(animated: true, completion: nil)
        } else if let mainNavigationController = navigationController {
            // If editing event
            mainNavigationController.popViewController(animated: true)
        } else {
            fatalError("The EventViewController is not contained in a UINavigationController")
        }
        
    }
    
    //MARK: Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//
//        guard let button = sender as? UIBarButtonItem, button === saveEventButton else {
//            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
//            return
//        }
//
//        // ?? asks if a UITextField.text has a value, and if it does, it returns that value. If it does not, it returns the String value placed after the ??
//
//        let name : String = eventNameField.text!
//        let startDateString : String = startDatePickerField.text!
//        let startDate : Date = dateFormatter.date(from: startDateString)!
//
//        let endDateString : String = endDatePickerField.text!
//        let endDate : Date = dateFormatter.date(from: endDateString)!
//        let description : String = descriptionTextView.text ?? ""
//        let image : UIImage = eventImage.image!
//
//        let event = Event(name: name, startDate: startDate, endDate: endDate, decsr: description, imageName: "image")
//
//        print("Successfully saved")
//    }
    
    //MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        eventImage.isUserInteractionEnabled = true
        eventImage.contentMode = .scaleAspectFit
        
        // Set delegate for all text fields and for the one text view, handle user input using this delegate
        self.eventNameField.delegate = self
        self.startDatePickerField.delegate = self
        self.endDatePickerField.delegate = self
        self.descriptionTextView.delegate = self
        
        // Set date picker and toolbar as input views
        
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        startDatePickerField.text = dateFormatter.string(from: Date())
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        datePicker.addTarget(self, action: #selector(EventDetailViewController.datePickerChangedValue(_:)), for: UIControl.Event.valueChanged)
        
        let doneButton : UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EventDetailViewController.doneSelection))
        
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
            eventNameField.text = event.name
            
            startDatePickerField.text = dateFormatter.string(from: event.startDate as Date)
            endDatePickerField.text = dateFormatter.string(from: event.endDate as Date)
            
            descriptionTextView.text = event.descr
            
            eventImage.image = UIImage(named: event.imageName)
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
        checkForAndResignFirstResponder()
    }
    
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
    
    //MARK: UITextView delegate method
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "Enter Description Here" {
            textView.text = ""
        }
        
    }
    
    //MARK: ImagePickerController delegate methods
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        guard let selected = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {
            fatalError("Wrong type of image or file, was of type: \(info)")
        }
        
        eventImage.image = selected
//        eventImage.frame.size.width = self.view.frame.size.width
        eventImage.contentMode = .scaleAspectFit
        dismiss(animated: true, completion: nil)
        print("Event image size is \(eventImage.frame.size)")
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
        let endDate : Date? = dateFormatter.date(from: endDatePickerField.text!)
        let startDate : Date? = dateFormatter.date(from: startDatePickerField.text!)
        
        saveEventButton.isEnabled = !(nameText.isEmpty || endDateText.isEmpty) && endDate! > startDate!
    }
    
    func checkForAndResignFirstResponder() {
        if eventNameField.isFirstResponder {
            eventNameField.resignFirstResponder()
        } else if descriptionTextView.isFirstResponder {
            descriptionTextView.resignFirstResponder()
        } else if startDatePickerField.isFirstResponder {
            startDatePickerField.resignFirstResponder()
        } else if endDatePickerField.isFirstResponder {
            endDatePickerField.resignFirstResponder()
        }
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
