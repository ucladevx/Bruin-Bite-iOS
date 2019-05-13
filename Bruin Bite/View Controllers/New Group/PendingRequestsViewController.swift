//
//  PendingRequestsViewController.swift
//  Bruin Bite
//
//  Created by Kameron Carr on 2/26/19.
//  Copyright © 2019 Dont Eat Alone. All rights reserved.
//

import UIKit

class SuccessfulMatchTableViewCell: UITableViewCell {
//    var name: String!
//    var location: String!
//    var time: String!
    @IBOutlet weak var backdrop: UIView!
    @IBOutlet weak var picImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    
}

class PendingMatchTableViewCell: UITableViewCell {
//    var location: String!
//    var time: String!
    @IBOutlet weak var backdrop: UIView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    
}

class PendingRequestsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LoginAlertPresentable {
    
    enum MealPeriod: String{
        case BR
        case LU
        case DI
        case LN
        case BU
        
        func getDisplayString() -> String {
            switch self {
            case .BR:
                return "Breakfast"
            case .LU:
                return "Lunch"
            case .DI:
                return "Dinner"
            case .LN:
                return "Late Night"
            case .BU:
                return "Brunch"
            }
        }
    }
    
    enum DiningHall: String{
        case DN
        case CO
        case BP
        case FE
        
        func getDisplayString() -> String {
            switch self {
            case .DN:
                return "De Neve"
            case .CO:
                return "Covel"
            case .BP:
                return "Bruin Plate"
            case .FE:
                return "Feast"
            }
        }
    }
    
    var cellType: String!
    var matches = [Match]()
    var requests = [Request]()
    var matchDateSections = [String:[Match]]()
    var matchDates = [Date]()
    var requestDateSections = [String:[Request]]()
    var requestDates = [Date]()
    
    @IBOutlet weak var matchTable: UITableView!
    @IBOutlet weak var switchTable: SuccessfulPendingSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //* Populate matches with test data
        let match = Match(user1: 1, user2: 2, user1_first_name: "Joe", user2_first_name: "Tommy", user1_last_name: "Bruin", user2_last_name: "Lee", meal_datetime: "2019-01-17T23:39:33+0000", meal_period: "LU", dining_hall: "DN", chat_url: String())
        let match2 = Match(user1: 1, user2: 2, user1_first_name: "Joe", user2_first_name: "Jason", user1_last_name: "Bruin", user2_last_name: "Todd", meal_datetime: "2019-01-19T23:39:33+0000", meal_period: "BR", dining_hall: "BP", chat_url: String())
        let match3 = Match(user1: 1, user2: 2, user1_first_name: "Joe", user2_first_name: "Jasper", user1_last_name: "Bruin", user2_last_name: "Jones", meal_datetime: "2019-01-19T11:39:33+0000", meal_period: "BR", dining_hall: "CO", chat_url: String())
        
        //* Populate requests with test data
        let request = Request(user: 1, meal_times: [String()], meal_day: "2019-02-11", meal_period: "DI", dining_hall: "FE", status: String())
        let request2 = Request(user: 1, meal_times: [String()], meal_day: "2019-02-19", meal_period: "LN", dining_hall: "BP", status: String())
        
        matches.append(match)
        matches.append(match2)
        matches.append(match3)
        requests.append(request)
        requests.append(request2)
        
        // Defauly configuration is on successful
        cellType = "Successful"
        
        populateSections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserManager.shared.getUID() == -1 { presentNotLoggedInAlert() }
    }
    
    func populateSections() {
        // Populate dictionary with date-array elements
        
        /*
         var tempMatchSections: [Date:[Match]]? = [Date:[Match]]()
         var tempRequestSections: [Date:[Request]]? = [Date:[Request]]()
         */
        
        // Dictionaries with unique Dates to sort later
        var tempMatchSections = [Date:Match]()
        var tempRequestSections = [Date:Request]()
        
        // Populate above dictionaries with matches/requests data
        for match in matches {
            let dateString = match.meal_datetime
            if let date = Date(fromRCF3339String: dateString) {
                tempMatchSections[date] = match
            }
        }
        
        for request in requests {
            let dateString = request.meal_day
            if let date = Date(fromYearMonthDayString: dateString) {
                tempRequestSections[date] = request
            }
        }
        
        // Sort the dates into Date arrays
        matchDates = Array(tempMatchSections.keys).sorted { date1, date2 in
            return date1 < date2
        }
        requestDates = Array(tempRequestSections.keys).sorted { date1, date2 in
            return date1 < date2
        }
        
        // Retrieve each corresponding match/request object for each date
        // and convert the date into a month/day/year formatted string
        for matchDate in matchDates {
            let dateString = matchDate.getPendingRequestsString()
            if let match = tempMatchSections[matchDate] {
                if (matchDateSections[dateString] == nil) {
                    matchDateSections[dateString] = [Match]()
                }
                matchDateSections[dateString]?.append(match)
            }
        }
        
        for requestDate in requestDates {
            let dateString = requestDate.getPendingRequestsString()
            if let request = tempRequestSections[requestDate] {
                if (requestDateSections[dateString] == nil) {
                    requestDateSections[dateString] = [Request]()
                }
                requestDateSections[dateString]?.append(request)
            }
        }
        
        /*
        tempMatchSections = nil
        tempRequestSections = nil
        */
    }
    
    @IBAction func switchTable(_ sender: Any) {
        switch switchTable.selectedSegmentIndex
        {
            case 0:
            // Switch to successful matches section
            cellType = "Successful"
            case 1:
            // Switch to pending matches section
            cellType = "Pending"
            default:
                break
        }
        switchTable.changeButtonBarPosition()
        matchTable.reloadData()
    }
    
    
    // MARK: - TableView Delegate Functions
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cellType == "Successful" {
            return 110.0
        } else {
            return 105.0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if cellType == "Successful" {
            return matchDateSections.keys.count
        } else {
            // If it is on the Pending segment
            return requestDateSections.keys.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellType == "Successful" {
            return Array(matchDateSections.values)[section].count
        } else {
            // If it is on the Pending segment
            return Array(requestDateSections.values)[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if cellType == "Successful" {
            return Array(matchDateSections.keys)[section]
        } else {
            // If it is on the Pending segment
            return Array(requestDateSections.keys)[section]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellType == "Successful" {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "successfulMatchNew", for: indexPath)
            let cell = tableView.dequeueReusableCell(withIdentifier: "successfulMatch", for: indexPath as IndexPath) as! SuccessfulMatchTableViewCell
            let match = matches[indexPath.row]
            cell.picImage.layer.masksToBounds = false
            cell.picImage.clipsToBounds = true
            cell.picImage.layer.cornerRadius = cell.picImage.frame.height/2
            cell.name.text = match.user2_first_name + " " + match.user2_last_name
            let mealAndLocation = (DiningHall(rawValue: match.meal_period)?.getDisplayString() ?? "Food") + " at " + (MealPeriod(rawValue: match.dining_hall)?.getDisplayString() ?? "UCLA")
            cell.location.text = mealAndLocation
            return cell
        } else {
            // If it is on the Pending segment
            let cell = tableView.dequeueReusableCell(withIdentifier: "pendingRequest", for: indexPath as IndexPath) as! PendingMatchTableViewCell
            let request = requests[indexPath.row]
            cell.backdrop.layer.masksToBounds = false
            cell.backdrop.clipsToBounds = true
            cell.backdrop.layer.cornerRadius = 10
            let mealAndLocation = (DiningHall(rawValue: request.meal_period)?.getDisplayString() ?? "Food") + " at " + (MealPeriod(rawValue: request.dining_hall)?.getDisplayString() ?? "UCLA")
            cell.location.text = mealAndLocation
            return cell
        }
    }
    
}
