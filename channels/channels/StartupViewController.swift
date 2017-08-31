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
    
    @IBOutlet weak var tryAgain: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    
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
            checkUser()
        }
    }
    
    @IBAction func onTryAgain(_ sender: UIButton) {
        register()
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
        self.showProgress("Connectiong to channels...")
        ChannelService.instance.register(inviteCode: shareCode) { (response: RegisterResponse?, err: Error?) in
            if err != nil {
                self.showError("Error registering with server: \(err!.localizedDescription)", tryAgain: true)
            } else {
                self.hideProgress()
                self.registered = true
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let firstTime = appDelegate.firstTime
                if firstTime  {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "EnableNotifications", sender: self)
                    }
                } else {
                    self.checkUser()
                }
            }
        }
    }
    
    private func checkUser() {
        self.gotoMain()
    }
    
    private func gotoMain() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "ShowFeed", sender: self)
        }
    }
    
    private func showProgress(_ message: String) {
        hideError()
        progressLabel.text = message
        progressLabel.isHidden = false
    }
    
    private func hideProgress() {
        progressLabel.text = ""
        progressLabel.isHidden = true
    }
    
    private func hideError() {
        errorLabel.text = "";
        errorLabel.isHidden = true
        tryAgain.isHidden = true
    }
    
    private func showError(_ message: String, tryAgain: Bool) {
        hideProgress()
        errorLabel.text = message
        errorLabel.isHidden = false
        self.tryAgain.isHidden = !tryAgain
    }
    
}
