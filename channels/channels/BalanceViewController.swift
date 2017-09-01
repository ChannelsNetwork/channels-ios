//
//  BalanceViewController.swift
//  channels
//
//  Created by Preet Shihn on 8/24/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController {
    
    @IBOutlet weak var userBalance: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        guard let status = ChannelService.instance.accountStatus else {
            return
        }
        userBalance.text = "Balance: CC " + String(format: "%.3f", status.userBalance)
    }

}
