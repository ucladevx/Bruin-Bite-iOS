//
//  PreferenceViewController.swift
//  Dont Eat Alone
//
//  Created by Ryan Lee on 5/1/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import CZPicker


class PreferenceViewController: UIViewController, MatchDelegate {

    @IBOutlet var TopView: UIView!
    @IBOutlet var TitleText: UILabel!
    @IBOutlet var MatchMeButton: UIButton!
    @IBOutlet var MealButton: UIButton!
    @IBOutlet var DiningHallButton: UIButton!
    @IBOutlet var DayButton: UIButton!
    @IBOutlet var TimeButton: UIButton!
    
    var picks = [String]()
    var meal_times = [String]()
    var meal_day = String()
    var dining_halls = [String]()
    var buttonSelected = false
    
    var generatedMatchID: Int? = nil // note:  if set, means that we can segue to searching screen. If not set, then we have a problem.
    
    let defaultText = [
        "Day": "What day are you free?",
        "DiningHall": "Which one's your favorite?",
        "MealPeriod": "When would you like to eat?",
        "Time": "Starting time?"
    ]
    
    @IBAction func MatchButton(_ sender: Any) {
        //TODO: Must check that the User has chosen a meal period!
        //Here you check each of the categories have been chosen but due to our previous methods of choosing a meal period, I have temporarily removed the check for a meal period
        //Basically we need to redo the meal period formatting/check from scratch
        if(chosen.isEmpty || meal_day == "" || dining_halls.isEmpty) {
            return
        }
        
        guard let meal_day_date = Date(fromUserFriendlyMonthDayYearString: meal_day) else {
            return
        }
        
        meal_times = chosen
        meal_day = meal_day_date.yearMonthDayString()
        for i in 0...meal_times.count-1 {
            meal_times[i] = meal_day + " " + meal_times[i]
            print(meal_times[i])
        }
        print(processTimes(meal_times))
        if(!meal_times.isEmpty && meal_day != "" && !dining_halls.isEmpty) {
        } else {
            return
        }
//        let storyBoard = UIStoryboard(name: "Matching", bundle: nil)
//        let searching = storyBoard.instantiateViewController(withIdentifier: "searchingForMatch")
//        
//        addChildViewController(searching)
//        view.addSubview(searching.view)
//        searching.didMove(toParentViewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.generatedMatchID != nil {
            self.performSegue(withIdentifier: "showSearchingVC", sender: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        meal_times = [String]()
        meal_day = String()
        dining_halls = [String]()
        DayButton.setTitle(defaultText["Day"], for: .normal)
        DiningHallButton.setTitle(defaultText["DiningHall"], for: .normal)
        MealButton.setTitle(defaultText["MealPeriod"], for: .normal)
        TimeButton.setTitle(defaultText["Time"], for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meal_day = ""
        // formatting top bar
        TopView.backgroundColor = UIColor.twilightBlue
        TitleText.font = UIFont.signUpTextFont.withSize(30)
        
        // formatting match button
        MatchMeButton.layer.borderWidth = 1
        MatchMeButton.layer.borderColor = UIColor.twilightBlue.cgColor
        MatchMeButton.layer.cornerRadius = 26
        
        // setting color and font of text field place holders
        DayButton.setTitle(defaultText["Day"], for: .normal)
        DayButton.setTitleColor(.pinkishGrey, for: .normal)
        DayButton.titleLabel?.font = UIFont.avenirNextItalicFont.withSize(18)
        
        DiningHallButton.setTitle(defaultText["DiningHall"], for: .normal)
        DiningHallButton.setTitleColor(.pinkishGrey, for: .normal)
        DiningHallButton.titleLabel?.font = UIFont.avenirNextItalicFont.withSize(18)
        
        MealButton.setTitle(defaultText["MealPeriod"], for: .normal)
        MealButton.setTitleColor(.pinkishGrey, for: .normal)
        MealButton.titleLabel?.font = UIFont.avenirNextItalicFont.withSize(18)
        
        TimeButton.setTitle(defaultText["Time"], for: .normal)
        TimeButton.setTitleColor(.pinkishGrey, for: .normal)
        TimeButton.titleLabel?.font = UIFont.avenirNextItalicFont.withSize(18)

        
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
        
        dining_halls.removeAll()
        
        picks = ["Covel", "De Neve", "Feast", "Bruin Plate"]
        picker?.delegate = self as CZPickerViewDelegate
        picker?.dataSource = self as CZPickerViewDataSource
        picker?.needFooterView = false
        picker?.allowMultipleSelection = true
        picker?.checkmarkColor = UIColor.twilightBlue
        picker?.headerBackgroundColor = UIColor.twilightBlue
        picker?.confirmButtonBackgroundColor = UIColor.twilightBlue
        picker?.cancelButtonBackgroundColor = UIColor.twilightBlue
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
        picker?.checkmarkColor = UIColor.twilightBlue
        picker?.headerBackgroundColor = UIColor.twilightBlue
        picker?.confirmButtonBackgroundColor = UIColor.twilightBlue
        picker?.cancelButtonBackgroundColor = UIColor.twilightBlue
        picker?.cancelButtonNormalColor = UIColor.white
        picker?.show()
    }
    
    @IBAction func selectTime(sender: AnyObject) {
        //Refactored storyboard
        let storyBoard = UIStoryboard(name: "PopupViewControllers", bundle: nil)
        if let timePicker = storyBoard.instantiateViewController(withIdentifier: "TimePickerViewController") as? TimePickerViewController {
            timePicker.delegate = self
            self.present(timePicker, animated: true)
            
            meal_times.removeAll()
        }
    }
    
    
    @IBAction func mealPeriod(_ sender: Any) {
        let picker = CZPickerView(headerTitle: "Meal Period", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        let meal_periods = ["Breakfast", "Lunch", "Dinner", "Latenight"]
        picks = meal_periods
        picker?.delegate = self as CZPickerViewDelegate
        picker?.dataSource = self as CZPickerViewDataSource
        picker?.needFooterView = false
        picker?.allowMultipleSelection = true
        
        picker?.checkmarkColor = UIColor.twilightBlue
        picker?.headerBackgroundColor = UIColor.twilightBlue
        picker?.confirmButtonBackgroundColor = UIColor.twilightBlue
        picker?.cancelButtonBackgroundColor = UIColor.twilightBlue
        picker?.cancelButtonNormalColor = UIColor.white
        picker?.show()
    }
    
    func didReceiveMatch(withID id: Int) {
        generatedMatchID = id
        self.performSegue(withIdentifier: "showSearchingVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSearchingVC" {
            if let destVC = segue.destination as? SearchingScreenViewController {
                destVC.matchID = self.generatedMatchID
            }
        }
    }
    
    @IBAction func unwindToPreferenceViewController(segue: UIStoryboardSegue) {
        self.generatedMatchID = nil
    }
}


extension PreferenceViewController: CZPickerViewDelegate, CZPickerViewDataSource, TimePickerViewControllerDelegate {
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
        DayButton.setTitle(picks[row], for: .normal)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!) {
        var chosen = String()
        var i = 1
        for row in rows {
            chosen += picks[row as! Int]
            switch(picks[row as! Int]) {
            case "Covel":
                dining_halls.append("CO")
                break
            case "De Neve":
                dining_halls.append("DN")
                break
            case "Bruin Plate":
                dining_halls.append("BP")
                break
            case "Feast":
                dining_halls.append("FE")
                break
            default:
                break
            }
            if(picks[0] != "Breakfast" && (picks[0] == "Covel" || picks[0] == "De Neve" || picks[0] == "Bruin Plate" || picks[0] == "Feast")) {
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

        //TODO: FInd a way to get the chosen meal period from User
        switch(picks[0]) {
        case "Covel":
            DiningHallButton.setTitle(chosen, for: .normal)
            if(chosen.isEmpty){
                DiningHallButton.setTitle(defaultText["DiningHall"], for: .normal)
            }
            break;
        case "Breakfast":
            MealButton.setTitle(chosen, for: .normal)
            switch(chosen) {
            case "Breakfast":
//                MAIN_USER.changeUserInfo(type: "period", info: "BR")
                break
            case "Lunch":
//                MAIN_USER.changeUserInfo(type: "period", info: "LU")
                break
            case "Dinner":
//                MAIN_USER.changeUserInfo(type: "period", info: "DI")
                break
            case "Latenight":
//                MAIN_USER.changeUserInfo(type: "period", info: "LN")
                break
            default:
                MealButton.setTitle(defaultText["MealPeriod"], for: .normal)
                break
            }
            break;
        case currentTime:
            //TimeButton.setTitle(chosen, for: .normal)
            break;
        default:
            DayButton.setTitle(chosen, for: .normal)
            if(chosen.isEmpty){
                DayButton.setTitle(defaultText["Day"], for: .normal)
            }
            meal_day = chosen
            break;
        }
        
    }
    
    func didConfirm(withChoices: String) {
        TimeButton.setTitle(withChoices, for: .normal)
        if(withChoices.isEmpty){
            TimeButton.setTitle(defaultText["Time"], for: .normal)
        }
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

