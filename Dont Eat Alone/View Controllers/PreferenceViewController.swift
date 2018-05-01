//
//  PreferenceViewController.swift
//  Dont Eat Alone
//
//  Created by Ryan Lee on 5/1/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class PreferenceViewController: UIViewController {

    @IBOutlet weak var dateField: UITextField!
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDataPicker()
        // Do any additional setup after loading the view.
    }
    
    func createDataPicker() {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        dateField.inputAccessoryView = toolbar
        dateField.inputView = picker
        //format picker for date
        picker.datePickerMode = .date
        var components = DateComponents()
        picker.minimumDate = Calendar.current.date(byAdding: components, to: Date())
        
    }
    
    @objc func donePressed() {
        //format date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: picker.date)
        
        dateField.text = "\(dateString)"
        self.view.endEditing(true)
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
    
}
