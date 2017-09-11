//
//  WebView.swift
//  channels
//
//  Created by Preet Shihn on 9/11/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit
import WebKit

class WebView: UIView, WKUIDelegate {
    private var wv: WKWebView?
    private var initialized = false
    
    var url: String? {
        didSet {
            guard let newUrl = url, let urlObj = URL(string: newUrl)  else {
                return
            }
            wv?.load(URLRequest(url: urlObj))
        }
    }
    
    var scrollable = true {
        didSet {
            wv?.scrollView.isScrollEnabled = scrollable
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initializeWebView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeWebView()
    }
    
    private func initializeWebView() {
        if !initialized {
            let config = WKWebViewConfiguration()
            wv = WKWebView(frame: self.bounds, configuration: config)
            initialized = true
            guard let view = wv else {
                return
            }
            view.scrollView.bounces = false
            view.translatesAutoresizingMaskIntoConstraints = false
            view.uiDelegate = self
            addSubview(view)
            addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0.0))
            addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0.0))
            addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0.0))
            addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0.0))
        }
    }
}
