//
//  UserFeedbackViewController.swift
//  Bruin Bite
//
//  Created by Hirday Gupta on 9/29/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import WebKit

class UserFeedbackViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var feedbackWebView: WKWebView!
    
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private let FEEDBACK_FORM_URL: URL = URL(string: "https://airtable.com/shrDnqfJ7cF0jqncc")
    private var URL_REQUEST: URLRequest {
        get {
            return URLRequest(url: FEEDBACK_FORM_URL)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up activity indicator
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        
        // Load web view
        feedbackWebView.load(URL_REQUEST)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        view.bringSubview(toFront: activityIndicator)
        activityIndicator.center = webView.center
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }

}
