//
//  RestRequest.swift
//  channels
//
//  Created by Preet Shihn on 8/23/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation
import ObjectMapper

class RestRequest<T: Mappable>: Mappable {
    var version: Int = 1
    var details: T?
    var signature: String?
    
    init(details: T, signature: String) {
        self.details = details
        self.signature = signature
        self.version = 1
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        version     <- map["version"]
        details     <- map["details"]
        signature   <- map["signature"]
    }
}

class Signable: Mappable {
    var address: String?
    var timestamp: Double?
    
    init(address: String, timestamp: Double) {
        self.address = address
        self.timestamp = timestamp
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        address     <- map["address"]
        timestamp   <- map["timestamp"]
    }
}

class RegisterUserDetails: Signable {
    var publicKey: String?
    var inviteCode: String?
    
    init(address: String, publicKey: String, inviteCode: String?, timestamp: Double) {
        super.init(address: address, timestamp: timestamp)
        self.publicKey = publicKey
        self.inviteCode = inviteCode
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        address     <- map["address"]
        timestamp   <- map["timestamp"]
    }
}
