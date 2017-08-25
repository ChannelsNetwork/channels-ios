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
    private var registered: Bool = false
    var shareCode: String? = nil
    
    override func viewDidLoad() {
        segueOnAppear = nil
        var hasKey = IdentityManager.instance.ensureKey(autoGenerate: false)
        if (!hasKey) {
            hasKey = IdentityManager.instance.ensureKey(autoGenerate: true)
            if (!hasKey) {
                UIUtils.showError("Faild to create key. This should never happen")
            } else {
                segueOnAppear = "AskShareCode"
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if segueOnAppear != nil {
            performSegue(withIdentifier: segueOnAppear!, sender: self)
            segueOnAppear = nil
        } else if !registered {
            register()
        } else {
            gotoMain()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sid = segue.identifier else {
            return
        }
        switch (sid) {
            case "AskShareCode":
                if let scvc = segue.destination as? ShareCodeViewController {
                    scvc.delegate = self
                }
            default:
                break
        }
    }
    
    private func register() {
        ChannelService.instance.register(inviteCode: shareCode) { (response: RegisterResponse?, err: Error?) in
            if err != nil {
                UIUtils.showError("Error registering with server: \(err!.localizedDescription)")
            } else {
                self.registered = true
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let firstTime = appDelegate.firstTime
                if firstTime  {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "EnableNotifications", sender: self)
                    }
                } else {
                    self.gotoMain()
                }
            }
        }
    }
    
    private func checkUser() {
    }
    
    private func gotoMain() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "ShowFeed", sender: self)
        }
    }
    
}
