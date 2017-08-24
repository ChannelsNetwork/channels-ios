//
//  ShareCodeViewController.swift
//  channels
//
//  Created by Preet Shihn on 8/17/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

protocol  ShareCodeViewDelegate: class {
    var shareCode: String? { get set }
}

class  ShareCodeViewController: UIViewController {
    @IBOutlet weak var shareCode: UITextField!
    weak var delegate: ShareCodeViewDelegate?
    
    @IBAction func onSubmit(_ sender: UIButton) {
        dismissView(code: shareCode.text)
    }
    
    @IBAction func onSkip(_ sender: UIButton) {
        dismissView(code: nil)
    }
    
    private func dismissView(code: String?) {
        self.delegate?.shareCode = code
        self.dismiss(animated: false, completion: nil)
    }
}
