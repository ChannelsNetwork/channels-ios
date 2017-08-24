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
    @IBOutlet weak var copyButton: UIButton!
    
    var shareCode: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        // copyButton.titleLabel!.text = "Copy to clipboard"
        code.text = shareCode
    }
    
    @IBAction func onCopy(_ sender: UIButton) {
        UIPasteboard.general.string = shareCode
//        DispatchQueue.main.async {
//            self.copyButton.titleLabel!.text = "Copied"
//        }
    }
    
    @IBAction func onClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
