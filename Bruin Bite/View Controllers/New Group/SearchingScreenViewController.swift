//
//  MatchScreenViewController.swift
//  Dont Eat Alone
//
//  Created by Kameron Carr on 5/6/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

// TODO: Writing the networking code for this VC here for now. To be changed to an API-style format.

import UIKit
import Pulsator
import Alamofire
import Repeat

struct MatchStatusData: Codable {
    var found_match: Bool
}

class SearchingScreenViewController: UIViewController {

    @IBOutlet weak var p: UIView!
    let puls = Pulsator()
    
    let BACKEND_MATCH_STATUS_URL = "https://dev.bruin-bite.com/api/v1/users/matching/data/"
    
    var matchID: Int? = nil
    var timer: Repeater? = nil
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.sendCheckIfMatchSuccesfulRequest()
        if (!puls.isPulsating) {
            puls.start()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.twilightBlue
        p.backgroundColor = UIColor.twilightBlue
        
        puls.numPulse = 4
        puls.radius = 120
        
        p.layer.addSublayer(puls)
        puls.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        if (!puls.isPulsating) {
            puls.start()
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveMatchStatusData(withStatus status: Bool) {
        if (status == true) {
            self.performSegue(withIdentifier: "MatchFound", sender: nil)
        }
    }
    
    func sendCheckIfMatchSuccesfulRequest() {
        let params = ["id": self.matchID ?? -1]
        Alamofire.request(BACKEND_MATCH_STATUS_URL, method: HTTPMethod.get, parameters: params, headers: nil).responseJSON { response in
            if let result = response.data {
                if let resultStruct = try? JSONDecoder().decode(MatchStatusData.self, from: result) {
                    self.didReceiveMatchStatusData(withStatus: resultStruct.found_match)
                } else {
                    print ("Error decoding match status data to MatchStatusData struct")
                }
            } else {
                print ("Error fetching match status data")
            }
        }
    }
    
    @IBAction func matchFound(_ sender: Any) {
        self.performSegue(withIdentifier: "NoMatchFound", sender: nil)
    }
}
