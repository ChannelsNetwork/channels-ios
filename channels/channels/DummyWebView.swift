//
//  DummyWebView.swift
//  channels
//
//  Created by Preet Shihn on 9/11/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

class DummyWebView: UIViewController {
    
    override func viewDidLoad() {
        if let wv = self.view as? WebView {
            wv.url = "http://www.google.com"
        }
    }
}
