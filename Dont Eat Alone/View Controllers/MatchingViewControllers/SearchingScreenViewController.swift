//
//  MatchScreenViewController.swift
//  Dont Eat Alone
//
//  Created by Kameron Carr on 5/6/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import Pulsator

class SearchingScreenViewController: UIViewController {

    @IBOutlet weak var p: UIView!
    let puls = Pulsator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        puls.numPulse = 2
        puls.radius = 100
        p.layer.addSublayer(puls)
        puls.backgroundColor = UIColor(red: 0, green: 0.46, blue: 0.76, alpha: 1).cgColor
        
        puls.start()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func matchFound(_ sender: Any) {
        self.performSegue(withIdentifier: "MatchFound", sender: nil)
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
