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

    @IBOutlet var TopView: UIView!
    @IBOutlet var TitleText: UILabel!
    @IBOutlet var MatchMeButton: UIButton!
    @IBOutlet var MealText: UITextField!
    @IBOutlet var DiningText: UITextField!
    @IBOutlet var DayText: UITextField!
    @IBOutlet var TimeButton: UIButton!
    
    var picks = [String]()
    
    
    @IBAction func HideText(_ sender: Any) {
        TimeButton.titleLabel?.textColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // formatting top bar
        TopView.backgroundColor = UIColor.twilightBlue
        TitleText.font = UIFont.signUpTextFont.withSize(30)
        
        // formatting match button
        MatchMeButton.layer.borderWidth = 1
        MatchMeButton.layer.borderColor = UIColor.twilightBlue.cgColor
        MatchMeButton.layer.cornerRadius = 26
        
        let attributes = [
        NSAttributedStringKey.foregroundColor: UIColor.pinkishGrey,
            NSAttributedStringKey.font: UIFont.avenirNextItalicFont
        ]
        
        // setting color and font of text field place holders
        DayText.attributedPlaceholder = NSAttributedString(string: "What day are you free?", attributes:attributes)
        DiningText.attributedPlaceholder = NSAttributedString(string: "Which one's your favorite?", attributes:attributes)
        MealText.attributedPlaceholder = NSAttributedString(string: "When would you like to eat?", attributes:attributes)
        TimeButton.titleLabel?.font = UIFont.avenirNextItalicFont
        
        
        //PREFILL DINING DATE AND TIME FIELDS
        //diningField.text = PUT IN USER PREFERRED DINING HALL WHEN YOU HAVE THE DATA
        var components = DateComponents()
        let curdate = Calendar.current.date(byAdding: components, to: Date())
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: curdate!)
        //DayText.text = "\(dateString)"
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        let timeString = formatter.string(from: curdate!)
        //TimeText.text = "\(timeString)"
        
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
        let components = DateComponents()
        var curdate = Calendar.current.date(byAdding: components, to: Date())
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        var i = 0
        var j = 1
        var temppicks = [String]()
        if(temppicks.count == 0) {
            while(i < 4) {
                let dateString = formatter.string(from: curdate!)
                curdate?.addTimeInterval(TimeInterval(60*60*24))
                temppicks.append(dateString)
                i += 1
                j += 1
            } }
        picks = temppicks
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
        //Refactored storyboard
        let storyBoard = UIStoryboard(name: "PopupViewControllers", bundle: nil)
        let timePicker = storyBoard.instantiateViewController(withIdentifier: "TimePickerViewController")
        self.present(timePicker, animated: true)
    }
    
    
    @IBAction func mealPeriod(_ sender: Any) {
        let picker = CZPickerView(headerTitle: "Meal Period", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        let meal_periods = ["Breakfast", "Lunch", "Dinner", "Latenight"]
        picks = meal_periods
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
    
    func czpickerView(pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int){
        print(row)
        DayText.text = picks[row]
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!) {
        var chosen = String()
        var i = 1
        for row in rows {
            chosen += picks[row as! Int]
            if(picks[0] != "Breakfast") {
            if i != rows.count {
                chosen += ", "
            }
            } else {
                break
            }
            i += 1
        }
        
        let components = DateComponents()
        var curdate = Calendar.current.date(byAdding: components, to: Date())
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        let currentTime = formatter.string(from: curdate!)
        
        switch(picks[0]) {
        case "Covel":
            DiningText.text = chosen
            break;
        case "Breakfast":
            MealText.text = chosen
            switch(chosen) {
            case "Breakfast":
                MAIN_USER.changeUserInfo(type: "period", info: "BR")
                break
            case "Lunch":
                MAIN_USER.changeUserInfo(type: "period", info: "LU")
                break
            case "Dinner":
                MAIN_USER.changeUserInfo(type: "period", info: "DI")
                break
            case "Latenight":
                MAIN_USER.changeUserInfo(type: "period", info: "LN")
            default:
                break
            }
            break;
        case currentTime:
            //TimeText.text = chosen
            break;
        default:
            DayText.text = chosen
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

