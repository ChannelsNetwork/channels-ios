//
//  ShareCodeViewController.swift
//  channels
//
//  Created by Preet Shihn on 8/17/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

class  ShareCodeViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "EnableNotifications":
                let ret = IdentityManager.instance.generateKeyPair()
                print("Key generation success: \(ret)")
                break;
            default:
                break;
            }
        }
    }
}
