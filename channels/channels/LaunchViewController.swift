//
//  LaunchViewController.swift
//  channels
//
//  Created by Preet Shihn on 8/24/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    @IBOutlet weak var countdown: UILabel!
    @IBOutlet weak var launchView: UIView!
    @IBOutlet weak var pendingView: UIView!
    @IBOutlet weak var pendingLabel: UILabel!
    
    private var status: AccountStatus?
    private var timer = Timer()
    private var timerRunning = false
    
    override func viewDidLoad() {
        status = ChannelService.instance.accountStatus
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refresh()
        if !timerRunning {
            runTimer()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
        timerRunning = false
    }
    
    private func refresh() {
        var diff = TimeInterval(status!.goLive / 1000)
        let now = Date().timeIntervalSince1970
        diff.subtract(now)
        
        if diff < 0 {
            launchView.isHidden = true
            pendingView.isHidden = false
            pendingLabel.text = "We're live but in limited release.  We'll let you know as soon as we're ready for you."
        } else {
            launchView.isHidden = false
            pendingView.isHidden = true
            updateCountdown(diff)
        }
    }
    
    private func updateCountdown(_ diff: TimeInterval) {
        let days = Int(diff) / (3600 * 24)
        let hours = Int(diff) / 3600 % 24
        let minutes = Int(diff) / 60 % 60
        let seconds = Int(diff) % 60
        var display = "";
        if days > 0 {
            display += "\(days)d "
        }
        if hours >= 0 {
            display += "\(hours)h "
        }
        if minutes >= 0 {
            display += "\(minutes)m "
        }
        if seconds >= 0 {
            display += "\(seconds)s"
        }
        countdown.text = display.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t: Timer) in
            self.refresh()
        })
        timerRunning = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sid = segue.identifier else {
            return
        }
        switch (sid) {
        case "InviteUser":
            if let ivc = segue.destination as? InviteViewController {
                ivc.shareCode = status?.inviteCode ?? "CHNLS"
            }
        default:
            break
        }
    }
}
