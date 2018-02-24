    //
//  FirstViewController.swift
//  Dont Eat Alone
//
//  Created by Ashwin Vivek on 1/27/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import Moya


class FirstViewController: UIViewController{
    
    @IBOutlet weak var m1: MenuCardView!
    let provider = MoyaProvider<API_methods>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        m1.tableView.delegate = m1
        m1.tableView.dataSource = m1
        
    }
    
    @IBAction func callAPI(_ sender: Any) {
        provider.request(.getAllMenus) { result in
            switch result {
            case let .success(moyaResponse):
                do{
                    try moyaResponse.filterSuccessfulStatusCodes() //makes sure the status code is 200...299
                    let data = try moyaResponse.mapJSON()
                    print(data)
                }
                catch{
                    let statusCode = moyaResponse.statusCode
                    print(statusCode)
                }
                
            // do something with the response data or statusCode
            case let .failure(error):
                print("Error")                  // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).  If the server responds with a 4xx or 5xx error, that
                // will be sent as a ".success"-ful response.
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

