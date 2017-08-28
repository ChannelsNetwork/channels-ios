//
//  EnableNotificationsViewController.swift
//  channels
//
//  Created by Preet Shihn on 8/25/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit
import OneSignal

class EnableNotificationsViewController: UIViewController {
    
    @IBAction func onSkip(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func onEnable(_ sender: UIButton) {
        if !_Platform.isSumulator {
            OneSignal.promptForPushNotifications(userResponse: { accepted in
                print("User accepted notifications: \(accepted)")
                self.dismiss(animated: false, completion: nil)
            })
        } else {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
