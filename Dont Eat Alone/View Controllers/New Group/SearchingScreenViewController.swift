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
        
        view.backgroundColor = UIColor.twilightBlue
        p.backgroundColor = UIColor.twilightBlue
        
        puls.numPulse = 4
        puls.radius = 120
        
        p.layer.addSublayer(puls)
        puls.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        puls.start()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        puls.start()
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
