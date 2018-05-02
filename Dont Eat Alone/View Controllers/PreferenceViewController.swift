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

    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var diningField: UITextField!
    var picks = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diningField.font = UIFont(name: "Avenir", size: 18)
        diningField.textColor = UIColor.darkGray
        dateField.font = UIFont(name: "Avenir", size: 18)
        dateField.textColor = UIColor.darkGray
        timeField.font = UIFont(name: "Avenir", size: 18)
        timeField.textColor = UIColor.darkGray
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showWithMultipleSelections(sender: AnyObject) {
        let picker = CZPickerView(headerTitle: "Dining Halls", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        
        picks = ["Covel", "De Neve", "Feast", "Bruin Plate"]
        picker?.delegate = self as CZPickerViewDelegate
        picker?.dataSource = self as CZPickerViewDataSource
        picker?.needFooterView = false
        picker?.allowMultipleSelection = true
        picker?.checkmarkColor = UIColor.deaScarlet
        picker?.headerBackgroundColor = UIColor.deaScarlet
        picker?.confirmButtonBackgroundColor = UIColor.deaScarlet
        picker?.cancelButtonBackgroundColor = UIColor.deaScarlet
        picker?.cancelButtonNormalColor = UIColor.white
        picker?.show()
    }
    
    @IBAction func selectDate(sender: AnyObject) {
        let picker = CZPickerView(headerTitle: "Dates", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        
        picks = ["May 2, 2018", "May 3, 2018", "May 4, 2018", "May 5, 2018"]
        picker?.delegate = self as CZPickerViewDelegate
        picker?.dataSource = self as CZPickerViewDataSource
        picker?.needFooterView = false
        picker?.allowMultipleSelection = true
        picker?.checkmarkColor = UIColor.deaScarlet
        picker?.headerBackgroundColor = UIColor.deaScarlet
        picker?.confirmButtonBackgroundColor = UIColor.deaScarlet
        picker?.cancelButtonBackgroundColor = UIColor.deaScarlet
        picker?.cancelButtonNormalColor = UIColor.white
        picker?.show()
    }
    
    @IBAction func selectTime(sender: AnyObject) {
        let picker = CZPickerView(headerTitle: "Times", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        
        picks = ["9:15pm", "9:30pm", "9:45pm", "10:00pm"]
        picker?.delegate = self as CZPickerViewDelegate
        picker?.dataSource = self as CZPickerViewDataSource
        picker?.needFooterView = false
        picker?.allowMultipleSelection = true
        picker?.checkmarkColor = UIColor.deaScarlet
        picker?.headerBackgroundColor = UIColor.deaScarlet
        picker?.confirmButtonBackgroundColor = UIColor.deaScarlet
        picker?.cancelButtonBackgroundColor = UIColor.deaScarlet
        picker?.cancelButtonNormalColor = UIColor.white
        picker?.show()
    }
    
}

extension PreferenceViewController: CZPickerViewDelegate, CZPickerViewDataSource {
        func numberOfRows(in pickerView: CZPickerView!) -> Int {
            return picks.count
        }
    
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
            return picks[row]
        }
        
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int){
        print(picks[row])
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            
        }
        
    func czpickerViewDidClickCancelButton(_ pickerView: CZPickerView!) {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!) {
        var chosen = String()
        var i = 1
        for row in rows {
            chosen += picks[row as! Int]
            if i != rows.count {
                chosen += ", "
            }
            i += 1
        }
        
        switch(picks[0]) {
        case "Covel":
            diningField.text = chosen
            break;
        case "9:15pm":
            timeField.text = chosen
            break;
        default:
            dateField.text = chosen
            break;
        }
        
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

