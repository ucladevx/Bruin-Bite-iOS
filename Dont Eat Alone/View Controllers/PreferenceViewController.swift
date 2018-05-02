//
//  PreferenceViewController.swift
//  Dont Eat Alone
//
//  Created by Ryan Lee on 5/1/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import CZPicker

class PreferenceViewController: UIViewController {

    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var diningField: UITextField!
    let diningpicker = CZPickerView(headerTitle: "Dining Hall", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
    
    let dininghalls = ["Covel", "De Neve", "Feast", "Bruin Plate"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diningField.font = UIFont(name: "Avenir", size: 18)
        diningField.textColor = UIColor.darkGray
        dateField.font = UIFont(name: "Avenir", size: 18)
        dateField.textColor = UIColor.darkGray
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showWithMultipleSelections(sender: AnyObject) {
        diningpicker?.delegate = self as CZPickerViewDelegate
        diningpicker?.dataSource = self as CZPickerViewDataSource
        diningpicker?.needFooterView = false
        diningpicker?.allowMultipleSelection = true
        diningpicker?.show()
    }
}


extension PreferenceViewController: CZPickerViewDelegate, CZPickerViewDataSource {
        func numberOfRows(in pickerView: CZPickerView!) -> Int {
            return dininghalls.count
        }
    
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
            return dininghalls[row]
        }
        
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int){
        print(dininghalls[row])
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            
        }
        
    func czpickerViewDidClickCancelButton(_ pickerView: CZPickerView!) {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!) {
        var chosen = String()
        var i = 1
        for row in rows {
            chosen += dininghalls[row as! Int]
            if i != rows.count {
                chosen += ", "
            }
            i += 1
        }
        diningField.text = chosen
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

