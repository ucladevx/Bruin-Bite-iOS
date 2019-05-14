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

class PendingRequestsViewController: UIViewController, LoginAlertPresentable {
    private var cellType: String!
    private let matchingAPI: MatchingAPI = MatchingAPI()
    
    @IBOutlet weak var matchTable: UITableView!
    @IBOutlet weak var switchTable: SuccessfulPendingSegmentedControl!
    
    // Data storing:
    var matches = [Match]()
    var requests = [Request]()
    var matchDateSections = [String:[Match]]()
    var matchDates = [Date]()
    var requestDateSections = [String:[Request]]()
    var requestDates = [Date]()
    
    private enum PendingRequestsViewType {
        case successful
        case pending
    }
    
    private var viewType: PendingRequestsViewType = .successful
    private var matchesDict: [Date:[Match]]? = nil
    private var requestsDict: [Date:[Request]]? = nil
    private var sortedMatchDates: [Date]? = nil
    private var sortedRequestDates: [Date]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserManager.shared.getUID() == -1 { presentNotLoggedInAlert() }
        matchingAPI.getMatches(completionDelegate: self, user: UserManager.shared.getUID())
        matchingAPI.getRequests(completionDelegate: self, user: UserManager.shared.getUID(), status: ["C", "P", "T"])
    }
    
    @IBAction func switchTable(_ sender: Any) {
        switch switchTable.selectedSegmentIndex
        {
            case 0:
            // Switch to successful matches section
            viewType = .successful
            case 1:
            // Switch to pending matches section
            viewType = .pending
            default:
                break
        }
        switchTable.changeButtonBarPosition()
        matchTable.reloadData()
    }
}

extension PendingRequestsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch viewType {
        case .successful:
            return sortedMatchDates?.count ?? 0
        case .pending:
            return sortedRequestDates?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewType {
        case .successful:
            guard let selectedDate = sortedMatchDates?[section] else {
                return 0
            }
            return matchesDict?[selectedDate]?.count ?? 0
        case .pending:
            guard let selectedDate = sortedRequestDates?[section] else {
                return 0
            }
            return requestsDict?[selectedDate]?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch viewType {
        case .successful:
            return sortedMatchDates?[section].pendingRequestsString()
        case .pending:
            return sortedRequestDates?[section].pendingRequestsString()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewType {
        case .successful:
            guard let currRowDate = sortedMatchDates?[indexPath.section],
                let currRowMatch = matchesDict?[currRowDate]?[indexPath.row],
                let cell = tableView.dequeueReusableCell(withIdentifier: "successfulMatch", for: indexPath as IndexPath) as? SuccessfulMatchTableViewCell else {
                    return UITableViewCell()
            }
            cell.picImage.layer.masksToBounds = false
            cell.picImage.clipsToBounds = true
            cell.picImage.layer.cornerRadius = cell.picImage.frame.height/2
            
            cell.name.text = currRowMatch.user2_first_name + " " + currRowMatch.user2_last_name
            
            let mealAndLocation = Utilities.mealPeriodName(forMealPeriodCode: currRowMatch.meal_period) + " at " + Utilities.diningHallName(forDiningHallCode: currRowMatch.dining_hall)
            cell.location.text = mealAndLocation
            return cell
        case .pending:
            guard let currRowDate = sortedRequestDates?[indexPath.section],
                let currRowRequest = requestsDict?[currRowDate]?[indexPath.row],
                let cell = tableView.dequeueReusableCell(withIdentifier: "pendingRequest", for: indexPath as IndexPath) as? PendingMatchTableViewCell else {
                    return UITableViewCell()
            }
            let mealAndLocation = Utilities.mealPeriodName(forMealPeriodCode: currRowRequest.meal_period) + " at " + Utilities.diningHallName(forDiningHallCode: currRowRequest.dining_hall)
            cell.location.text = mealAndLocation
            return cell
        }
    }
}

extension PendingRequestsViewController: GetMatchesDelegate {
    func didReceiveMatches(matches: [Match]) {
        guard matches.count > 0 else {
            self.sortedMatchDates = nil
            self.matchesDict = nil
            return
        }
        
        self.matchesDict = [:]
        self.sortedMatchDates = []
        
        for match in matches {
            guard let requestDate = Date(fromMatchRequestMealTimeString: match.meal_datetime) else {
                continue
            }
            self.sortedMatchDates?.append(requestDate)
            if matchesDict?[requestDate] != nil {
                self.matchesDict?[requestDate]?.append(match)
            } else {
                self.matchesDict?[requestDate] = [match]
            }
        }
        self.matchTable.reloadData()
    }
}

extension PendingRequestsViewController: GetRequestsDelegate {
    func didReceiveRequests(requests: [Request]) {
        guard requests.count > 0 else {
            self.sortedRequestDates = nil
            self.requestsDict = nil
            return
        }
        
        self.requestsDict = [:]
        self.requestDates = []
        
        for request in requests {
            guard let requestDate = Date(fromYearMonthDayString: request.meal_day) else {
                continue
            }
            self.sortedRequestDates?.append(requestDate)
            if requestsDict?[requestDate] != nil {
                self.requestsDict?[requestDate]?.append(request)
            } else {
                self.requestsDict?[requestDate] = [request]
            }
        }
        self.matchTable.reloadData()
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
            if let date = Date(fromMatchRequestMealTimeString: dateString) {
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
            let dateString = matchDate.pendingRequestsString()
            if let match = tempMatchSections[matchDate] {
                if (matchDateSections[dateString] == nil) {
                    matchDateSections[dateString] = [Match]()
                }
                matchDateSections[dateString]?.append(match)
            }
        }
        
        for requestDate in requestDates {
            let dateString = requestDate.pendingRequestsString()
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
}
