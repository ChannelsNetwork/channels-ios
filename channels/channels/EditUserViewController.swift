//
//  EditUserViewController.swift
//  channels
//
//  Created by Preet Shihn on 8/25/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

class EditUserViewController: UIViewController {
    @IBOutlet weak var formTitle: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var handle: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var save: UIButton!
    
    var newUser: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        if newUser {
            formTitle.text = "New user"
            cancel.isHidden = true
        } else {
            formTitle.text = "Edit user"
            cancel.isHidden = false
        }
        if let uid = IdentityManager.instance.userIdentity {
            name.text = uid.name ?? ""
            handle.text = uid.handle ?? ""
            location.text = uid.location ?? ""
        } else {
            name.text = ""
            handle.text = ""
            location.text = ""
        }
    }
    
    @IBAction func onSave(_ sender: UIButton) {
        let newName = name.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let newHandle = handle.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let newLoaction = location.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if (newName.characters.count  * newHandle.characters.count) == 0 {
            UIUtils.showAlert(titled: "Invalid entry", withMessage: "Name and Handle fields cannot be empty.")
        } else {
            let newIdentity = UserIdentity(address: IdentityManager.instance.userAddress, name: newName, handle: newHandle, location: newLoaction)
            IdentityManager.instance.saveUserIdentity(newIdentity, callback: { (err: Error?) in
                if let error = err {
                    UIUtils.showError("Failed to update user profile on the server: \(error.localizedDescription)")
                }
            })
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func onCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
