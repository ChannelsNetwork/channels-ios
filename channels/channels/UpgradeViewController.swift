//
//  UpgradeViewController.swift
//  channels
//
//  Created by Preet Shihn on 9/6/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

class UpgradeViewController: UIViewController {
    var appUrl: String?
    
    @IBAction func onUpgrade(_ sender: AButton) {
        guard let urlString = self.appUrl else {
            self.dismiss(animated: false, completion: nil)
            return
        }
        guard let url = URL(string: urlString) else {
            self.dismiss(animated: false, completion: nil)
            return
        }
        UIApplication.shared.open(url)
    }
}
