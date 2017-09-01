//
//  RestRequest.swift
//  channels
//
//  Created by Preet Shihn on 8/23/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation
import ObjectMapper

class RestRequest: Mappable {
    var version: Int = 1
    var details: String?
    var signature: String?
    
    init(details: String, signature: String) {
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
    var timestamp: Int64?
    
    init(address: String, timestamp: Int64) {
        self.address = address
        self.timestamp = timestamp
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        address     <- map["address"]
        timestamp   <- (map["timestamp"], CoreUtils.transformInt64)
    }
}

class RegisterUserDetails: Signable {
    var publicKey: String?
    var inviteCode: String?
    
    init(address: String, publicKey: String, inviteCode: String?, timestamp: Int64) {
        super.init(address: address, timestamp: timestamp)
        self.publicKey = publicKey
        self.inviteCode = inviteCode
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        publicKey     <- map["publicKey"]
        inviteCode   <- map["inviteCode"]
    }
}

class GetUserIdentityDetails: Signable {}

class RegisterDeviceDetails: Signable {
    var deviceToken: String?
    
    init(address: String, token: String, timestamp: Int64) {
        super.init(address: address, timestamp: timestamp)
        self.deviceToken = token
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        deviceToken     <- map["deviceToken"]
    }
}

class UpdateIdentityDetails: Signable {
    var name: String?
    var handle: String?
    var location: String?
    var imageUrl: String?
    
    init(address: String, name: String, handle: String, location: String?, timestamp: Int64) {
        super.init(address: address, timestamp: timestamp)
        self.name = name
        self.handle = handle
        self.location = location
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name     <- map["name"]
        handle   <- map["handle"]
        location   <- map["location"]
        imageUrl   <- map["imageUrl"]
    }
}
