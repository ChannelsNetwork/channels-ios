//
//  Config.swift
//  channels
//
//  Created by Preet Shihn on 8/23/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation

struct Config {
    static let kServerUrl = "serverUrl"
    
    private static var properties: [String: Any]?
    
    private static func ensureLoaded() {
        if properties != nil {
            return
        }
        guard let path = Bundle.main.path(forResource: "config", ofType: "plist") else {
            print("Failed to load config file")
            return
        }
        guard let dict = NSDictionary(contentsOfFile: path) as? [String: Any] else {
            print("Failed to load config file as a dictionary")
            return
        }
        properties = dict
    }
    
    static func get(_ key: String) -> String? {
        ensureLoaded()
        return (properties?[key] as? String)
    }
}
