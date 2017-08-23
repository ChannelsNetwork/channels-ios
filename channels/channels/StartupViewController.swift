//
//  StartupViewController.swift
//  channels
//
//  Created by Preet Shihn on 8/22/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

class StartupViewController: UIViewController, ShareCodeViewDelegate {
    private var segueOnAppear: String?
    var shareCode: String?
    
    override func viewDidLoad() {
        segueOnAppear = nil
        var hasKey = IdentityManager.instance.ensureKey(autoGenerate: false)
        if (!hasKey) {
            hasKey = IdentityManager.instance.ensureKey(autoGenerate: true)
            if (!hasKey) {
                print("Faild to create key. This should never happen")
            } else {
                segueOnAppear = "AskShareCode"
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if segueOnAppear != nil {
            performSegue(withIdentifier: segueOnAppear!, sender: self)
            segueOnAppear = nil
        } else {
            register()
        }
    }
    
    private func register() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "ShowFeed", sender: self)
        }
    }
    
}
