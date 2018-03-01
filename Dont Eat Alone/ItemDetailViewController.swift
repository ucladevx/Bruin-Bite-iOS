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
        
        webView.frame = CGRect(x: webView.frame.origin.x, y: 0.15*UIScreen.main.bounds.height, width: 0.63*UIScreen.main.bounds.width, height: 0.515*UIScreen.main.bounds.height)
        
        webView.center.x = self.view.center.x
        
        ingredientsBar.frame = CGRect(x: 0, y: 0.75*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0.25*UIScreen.main.bounds.height)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
