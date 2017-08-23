//
//  StartupViewController.swift
//  channels
//
//  Created by Preet Shihn on 8/22/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

class StartupViewController: UIViewController {
    
    override func viewDidLoad() {
        let hasKey = IdentityManager.instance.ensureKey(autoGenerate: false)
        print("Has key: \(hasKey)")
    }
    
//    @IBAction func handleGo(_ sender: UIButton) {
//        performSegue(withIdentifier: "Startup", sender: self)
//    }
    
}
