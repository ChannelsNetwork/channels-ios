//
//  BlogViewController.swift
//  channels
//
//  Created by Preet Shihn on 8/24/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

class BlogViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        webView.loadRequest(URLRequest(url: URL(string: "https://medium.com/channels-network")!))
    }
}
