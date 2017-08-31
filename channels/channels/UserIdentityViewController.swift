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
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var noProfileView: UIView!
    
    private var shouldEdit = true
    
    override func viewWillAppear(_ animated: Bool) {
        if let uid = IdentityManager.instance.userIdentity {
            name.text = uid.name ?? ""
            handle.text = uid.handle ?? ""
            location.text = uid.location ?? ""
            profileView.isHidden = false
            noProfileView.isHidden = true
        } else {
            profileView.isHidden = true
            noProfileView.isHidden = false
        }
    }
    
    @IBAction func onEdit(_ sender: AButton) {
        shouldEdit = true
        performSegue(withIdentifier: "EditProfile", sender: self)
    }
    
    @IBAction func onCreate(_ sender: AButton) {
        shouldEdit = false
        performSegue(withIdentifier: "EditProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sid = segue.identifier else {
            return
        }
        switch (sid) {
        case "EditProfile":
            if let viewController = segue.destination as? EditUserViewController {
                viewController.newUser = !self.shouldEdit
            }
        default:
            break
        }
    }
}
