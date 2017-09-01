//
//  InviteViewController.swift
//  channels
//
//  Created by Preet Shihn on 8/24/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

class InviteViewController: UIViewController {
    
    @IBOutlet weak var code: UILabel!
    
    var shareCode: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        code.text = shareCode
    }
    
    @IBAction func onCopy(_ sender: UIButton) {
        UIPasteboard.general.string = shareCode
    }
    
    @IBAction func onClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
