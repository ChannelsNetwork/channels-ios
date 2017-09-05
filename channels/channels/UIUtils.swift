//
//  UIUtils.swift
//  channels
//
//  Created by Preet Shihn on 8/23/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

struct UIUtils {
    private static func getCurrentView() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    static func showError(_ message: String, callback: (() -> Void)? = nil) {
        showAlert(titled: "Error", withMessage: message, callback: callback)
    }
    
    static func showAlert(titled title: String, withMessage message: String, callback: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (_) in
                callback?()
            }))
            getCurrentView()?.present(alert, animated: true, completion: nil)
        }
    }
    
    static func dataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
}
