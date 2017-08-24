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
    @IBOutlet weak var networkBalance: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        guard let status = ChannelService.instance.accountStatus else {
            return
        }
        userBalance.text = String(status.userBalance)
        networkBalance.text = String(status.networkBalance)
    }

}
