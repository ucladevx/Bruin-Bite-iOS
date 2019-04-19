//
//  PreferenceViewController.swift
//  Bruin Bite
//
//  Created by Hirday Gupta on 4/13/19.
//  Copyright © 2019 Dont Eat Alone. All rights reserved.
//

import Foundation
import UIKit
import CZPicker

class PreferenceViewController: UIViewController {
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var DayBtn: UIButton!
    @IBOutlet weak var DiningHallBtn: UIButton!
    @IBOutlet weak var MealPeriodBtn: UIButton!
    @IBOutlet weak var TimeBtn: UIButton!
    @IBOutlet weak var MatchMeBtn: UIButton!
    
    let DEFAULT_TEXT: [String:String] = [
        "Day": "What day are you free?",
        "DiningHall": "Where do you want to eat?",
        "MealPeriod": "When would you like to eat?",
        "Time": "Starting time?"
    ]
    
    let ERROR_TEXT: [String: String] = [
        "Day": "Please select a date!",
        "DiningHall": "Select a dining hall!",
        "MealPeriod": "Choose a meal period!",
        "Time": "Pick a start time!"
    ]
    
    private let datePicker: CZPickerView = CZPickerView(headerTitle: "Dates", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
    private let diningHallPicker: CZPickerView = CZPickerView(headerTitle: "Dining Halls", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
    private let mealPeriodPicker: CZPickerView = CZPickerView(headerTitle: "Meal Periods", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
    // private let timePicker: CZPickerView = CZPickerView(headerTitle: "Start Times", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")

    
    // get-only variable that calculates the next 5 dates.
    private var datePicks: [Date] {
        get {
            var dates: [Date] = []
            let currentDate = Date(fromStartOfDate: true) ?? Date()
            for i in 0..<5 {
                dates.append( Calendar.current.date(byAdding: .day, value: i, to: currentDate) ?? currentDate)
            }
            return dates
        }
    }
    private let diningHallPicks = ["De Neve", "Covel", "Bruin Plate", "Feast"]
    private let mealPeriodPicks = ["Breakfast", "Lunch", "Dinner"]
    
    private var selectedDate: Date? = nil
    private var selectedDiningHalls: [String]? = nil
    private var selectedMealPeriod: String? = nil
    private var selectedDateTimes: [Date]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // formatting top bar
        TopView.backgroundColor = UIColor.twilightBlue
        
        // setting title texts for buttons
        DayBtn.setTitle(DEFAULT_TEXT["Day"], for: .normal)
        DiningHallBtn.setTitle(DEFAULT_TEXT["DiningHall"], for: .normal)
        MealPeriodBtn.setTitle(DEFAULT_TEXT["MealPeriod"], for: .normal)
        TimeBtn.setTitle(DEFAULT_TEXT["Time"], for: .normal)
        
        setUpPickers()
    }
    
    @IBAction func didPressDayBtn(_ sender: Any) {
        datePicker.show()
    }
    
    @IBAction func didPressDiningHallBtn(_ sender: Any) {
        diningHallPicker.show()
    }
    
    @IBAction func didPressMealPeriodBtn(_ sender: Any) {
        mealPeriodPicker.show()
    }
    
    @IBAction func didPressTimeBtn(_ sender: Any) {
        guard let selectedDate = selectedDate else{
            Utilities.sharedInstance.displayErrorLabel(text: ERROR_TEXT["Day"] ?? "", field: DayBtn)
            return
        }
        guard let selectedMealPeriod = selectedMealPeriod else {
            Utilities.sharedInstance.displayErrorLabel(text: ERROR_TEXT["MealPeriod"] ?? "", field: MealPeriodBtn)
            return
        }
        let storyBoard = UIStoryboard(name: "PopupViewControllers", bundle: nil)
        if let timePicker = storyBoard.instantiateViewController(withIdentifier: "TimePickerViewController") as? TimePickerViewController {
            timePicker.delegate = self
            timePicker.chosen_meal_period = selectedMealPeriod
            timePicker.chosen_date = selectedDate
            self.present(timePicker, animated: true)
        }
    }
    
    @IBAction func didPressMatchMe(_ sender: Any) {
        guard let selectedDate = selectedDate else {
            Utilities.sharedInstance.displayErrorLabel(text: ERROR_TEXT["Day"] ?? "", field: DayBtn)
            return
        }
        guard let selectedDiningHalls = selectedDiningHalls else {
            Utilities.sharedInstance.displayErrorLabel(text: ERROR_TEXT["DiningHall"] ?? "", field: DiningHallBtn)
            return
        }
        guard let selectedMealPeriod = selectedMealPeriod else {
            Utilities.sharedInstance.displayErrorLabel(text: ERROR_TEXT["MealPeriod"] ?? "", field: MealPeriodBtn)
            return
        }
        guard let selectedDatetimes = selectedDateTimes else {
            Utilities.sharedInstance.displayErrorLabel(text: ERROR_TEXT["Time"] ?? "", field: TimeBtn)
            return
        }
        
        // TODO: Figure out date formats
        let selectedDateTimeStrings = selectedDatetimes.map { $0.matchRequestMealTimeString() }
        let selectedDateString = selectedDate.yearMonthDayString()
        // request:
    }

    private func setUpPickers() {
        datePicker.dataSource = self
        datePicker.delegate = self
        datePicker.needFooterView = true
        datePicker.checkmarkColor = .twilightBlue
        datePicker.headerBackgroundColor = .twilightBlue
        datePicker.confirmButtonBackgroundColor = .twilightBlue
        datePicker.cancelButtonBackgroundColor = .twilightBlue
        datePicker.cancelButtonNormalColor = .white
        
        diningHallPicker.dataSource = self
        diningHallPicker.delegate = self
        diningHallPicker.needFooterView = true
        diningHallPicker.allowMultipleSelection = true
        diningHallPicker.checkmarkColor = .twilightBlue
        diningHallPicker.headerBackgroundColor = .twilightBlue
        diningHallPicker.confirmButtonBackgroundColor = .twilightBlue
        diningHallPicker.cancelButtonBackgroundColor = .twilightBlue
        diningHallPicker.cancelButtonNormalColor = .white
        
        mealPeriodPicker.dataSource = self
        mealPeriodPicker.delegate = self
        mealPeriodPicker.needFooterView = true
        mealPeriodPicker.checkmarkColor = .twilightBlue
        mealPeriodPicker.headerBackgroundColor = .twilightBlue
        mealPeriodPicker.confirmButtonBackgroundColor = .twilightBlue
        mealPeriodPicker.cancelButtonBackgroundColor = .twilightBlue
        mealPeriodPicker.cancelButtonNormalColor = .white
    }
    
}

extension PreferenceViewController: CZPickerViewDataSource {
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        switch pickerView {
        case datePicker:
            return datePicks.count
        case diningHallPicker:
            return diningHallPicks.count
        case mealPeriodPicker:
            return mealPeriodPicks.count
        default:
            return 0
        }
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        switch pickerView {
        case datePicker:
            return datePicks[row].userFriendlyMonthDayYearString()
        case diningHallPicker:
            return diningHallPicks[row]
        case mealPeriodPicker:
            return mealPeriodPicks[row]
        default:
            return ""
        }
    }
}

extension PreferenceViewController: CZPickerViewDelegate {
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
        switch pickerView {
        case datePicker:
            let oldDate = selectedDate
            selectedDate = datePicks[row]
            DayBtn.setTitle(datePicks[row].userFriendlyMonthDayYearString(), for: .normal)

            // Must reset selected times if date selection changed
            if oldDate != selectedDate {
                selectedDateTimes = nil
                TimeBtn.setTitle(DEFAULT_TEXT["Time"], for: .normal)
            }
        case mealPeriodPicker:
            let oldMealPeriod = selectedMealPeriod
            selectedMealPeriod = mealPeriodCode(forMealPeriod: mealPeriodPicks[row])
            MealPeriodBtn.setTitle(mealPeriodPicks[row], for: .normal)

            // Must reset selected times if meal period selection changes
            if oldMealPeriod != selectedMealPeriod {
                selectedDateTimes = nil
                TimeBtn.setTitle(DEFAULT_TEXT["Time"], for: .normal)
            }
        default:
            print ("Sumfin's wrong")
        }
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!) {
        // multiple selected
        
        // zero selections handled in czpickerViewDidDismiss
        // only dining hall CZPicker supports multiple as of now..
        guard rows.count != 0 && pickerView == diningHallPicker else  {
            return
        }
        guard let rows = rows as? [NSNumber] else {
            return
        }
        selectedDiningHalls = []
        for i in rows {
            selectedDiningHalls?.append(diningHallPicks[i.intValue])
        }

        let str = selectedDiningHalls?.joined(separator: ", ") ?? DEFAULT_TEXT["DiningHall"]
        DiningHallBtn.setTitle(str, for: .normal)
    }
    
    func czpickerViewDidDismiss(_ pickerView: CZPickerView!) {
        switch pickerView {
        case datePicker:
            if pickerView.selectedRows()?.count ?? 0 < 1 {
                selectedDate = nil
                DayBtn.setTitle(DEFAULT_TEXT["Day"], for: .normal)
            }
        case diningHallPicker:
            if pickerView.selectedRows()?.count ?? 0 < 1 {
                selectedDiningHalls = nil
                DiningHallBtn.setTitle(DEFAULT_TEXT["Day"], for: .normal)
            }
        case mealPeriodPicker:
            if pickerView.selectedRows()?.count ?? 0 < 1 {
                selectedMealPeriod = nil
                MealPeriodBtn.setTitle(DEFAULT_TEXT["Day"], for: .normal)
            }
        default:
            print ("Gon' Fishin'")
        }
    }
}

extension PreferenceViewController: TimePickerViewControllerDelegate {
    func didConfirm(withChoices choices: [Date]) {
        if choices.isEmpty {
            TimeBtn.setTitle(DEFAULT_TEXT["Time"], for: .normal)
            return
        }
        selectedDateTimes = choices
        let dateTimeStrings = choices.map { $0.hourMinuteString() }
        TimeBtn.setTitle(dateTimeStrings.joined(separator: ", "), for: .normal)
    }
}
