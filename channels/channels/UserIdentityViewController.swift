//
//  UserIdentityViewController.swift
//  channels
//
//  Created by Preet Shihn on 8/22/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

class UserIdentityViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var location: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        if let uid = IdentityManager.instance.userIdentity {
            name.text = uid.name ?? "Your name"
            handle.text = uid.handle ?? "Your handle"
            location.text = uid.location ?? "Your location"
        } else {
            name.text = "Your name"
            handle.text = "Your handle"
            location.text = "Your location"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sid = segue.identifier else {
            return
        }
        switch (sid) {
        case "EditProfile":
            if let viewController = segue.destination as? EditUserViewController {
                viewController.newUser = false
            }
        default:
            break
        }
    }
}
