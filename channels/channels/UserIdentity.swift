//
//  UserIdentity.swift
//  channels
//
//  Created by Preet Shihn on 8/21/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation
import ObjectMapper

class UserIdentity: Mappable {
    var name: String?
    var address: String?
    var handle: String?
    var location: String?
    var timestamp: Int = 0
    
    required init?(map: Map) {
    }
    
    init(address: String, name: String, handle: String, location: String?, timestamp: Int = 0) {
        self.name = name;
        self.address = address
        self.handle = handle
        self.location = location
        if timestamp > 0 {
            self.timestamp = timestamp
        } else {
            self.timestamp = Int((Date().timeIntervalSince1970) * 1000)
        }
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        address <- map["address"]
        handle <- map["handle"]
        location <- map["location"]
        timestamp <- map["timestamp"]
    }
}
