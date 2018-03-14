//
//  ItemDetailViewController.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 2/28/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import WebKit

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var ingredientsBar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.scrollView.isScrollEnabled = false
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let url = URL(string: "http://13.57.209.253:5000/api/v1/menu/nutritionfacts"){
            let urlRequest: URLRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
