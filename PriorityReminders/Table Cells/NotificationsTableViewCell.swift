//
//  NotificationsTableViewCell.swift
//  PriorityReminders
//
//  Created by Yashas Lokesh on 6/5/18.
//  Copyright © 2018 Yashas Lokesh. All rights reserved.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var notificationSettingLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var timeSettingTextField: UITextField!
    
    let timeSettings = ["Hours","Days","Weeks","Months"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        numberTextField.keyboardType = .numberPad
        self.setupTextFieldInputs(timeSettingTextField, numberTextField)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeSettings.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeSettings[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timeSettingTextField.text = timeSettings[row]
    }
    
    func setupTextFieldInputs(_ timeTextField : UITextField, _ numberTextField : UITextField) -> Void {
        
        let timePicker = UIPickerView()
        timePicker.delegate = self
        timePicker.dataSource = self
        
        let doneButton : UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(NotificationsTableViewCell.doneSelection(_:)))
        
        let toolbar : UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        timeTextField.inputView = timePicker
        timeTextField.inputAccessoryView = toolbar
        
        numberTextField.inputAccessoryView = toolbar
        
    }
    
    @objc func doneSelection(_ sender : UIBarButtonItem) -> Void {
        if timeSettingTextField.isFirstResponder {
            timeSettingTextField.resignFirstResponder()
        } else {
            numberTextField.resignFirstResponder()
        }
    }
    
//    func setNotificationSettingLabel(name : String) -> Void {
//        self.notificationSettingLabel.text = name
//    }

}
