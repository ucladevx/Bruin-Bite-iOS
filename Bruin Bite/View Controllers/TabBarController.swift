//
//  TabBarController.swift
//  Bruin Bite
//
//  Created by Jonathan Davies on 10/20/19.
//  Copyright © 2019 Dont Eat Alone. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        self.navigationController?.navigationBar.barTintColor = UIColor.green
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func statusBarHeight() -> CGFloat {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        return Swift.min(statusBarSize.width, statusBarSize.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get screen size object.
        let screenSize: CGRect = UIScreen.main.bounds
        
        // get screen width.
        let screenWidth = screenSize.width
        
        // get screen height.
        let screenHeight = screenSize.height
        
        // the rectangle top left point x axis position.
        let xPos = 0
        
        // the rectangle top left point y axis position.
        let yPos = 0
        
        // the rectangle width.
        let rectWidth = Int(screenWidth)
        
        // the rectangle height.
        let rectHeight = statusBarHeight()
        
        // Create a CGRect object which is used to render a rectangle.
        let rectFrame: CGRect = CGRect(x:CGFloat(xPos), y:CGFloat(yPos), width:CGFloat(rectWidth), height:CGFloat(rectHeight))
        
        // Create a UIView object which use above CGRect object.
        let greenView = UIView(frame: rectFrame)
        
        // Set UIView background color.
        greenView.backgroundColor = UIColor.twilightBlue
        
        // Add above UIView object as the main view's subview.
        self.view.addSubview(greenView)

//        self.navigationController?.navigationBar.barTintColor = UIColor.green
        self.navigationItem.setHidesBackButton(true, animated: false)
//        UIApplication.shared.statusBarStyle = .default
            // Fallback on earlier versions
//        statusbarView.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
