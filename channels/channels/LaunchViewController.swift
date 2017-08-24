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
    
    private var status: AccountStatus?
    private var timer = Timer()
    private var timerRunning = false
    
    override func viewDidLoad() {
        status = ChannelService.instance.accountStatus
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateCountdown()
        if !timerRunning {
            runTimer()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
        timerRunning = false
    }
    
    private func updateCountdown() {
        var diff = TimeInterval(status!.goLive / 1000)
        let now = Date().timeIntervalSince1970
        diff.subtract(now)
        let days = Int(diff) / (3600 * 24)
        let hours = Int(diff) / 3600 % 24
        let minutes = Int(diff) / 60 % 60
        let seconds = Int(diff) % 60
        let display = String(format:"%02i days\n%02i hours\n%02i minutes\n%02i seconds", days, hours, minutes, seconds)
        countdown.text = display
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t: Timer) in
            self.updateCountdown()
        })
        timerRunning = true
    }
    
    @IBAction func onInvite(_ sender: UIButton) {
    }
}
