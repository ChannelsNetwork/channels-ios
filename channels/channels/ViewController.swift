//
//  ViewController.swift
//  channels
//
//  Created by Preet Shihn on 8/15/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func handleGo(_ sender: UIButton) {
        performSegue(withIdentifier: "Startup", sender: self)
    }
    
}

