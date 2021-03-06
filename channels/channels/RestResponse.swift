//
//  RestResponse.swift
//  channels
//
//  Created by Preet Shihn on 8/28/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation
import ObjectMapper


class RegisterResponse: Mappable {
    var status: AccountStatus?
    var appUpdateUrl: String?
    var socketUrl: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status          <- map["status"]
        appUpdateUrl    <- map["appUpdateUrl"]
        socketUrl       <- map["socketUrl"]
    }
}

class GetUserIdentityResponse: Mappable {
    var name: String?
    var location: String?
    var handle: String?
    var imageUrl: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name  <- map["name"]
        location  <- map["location"]
        handle  <- map["handle"]
        imageUrl  <- map["imageUrl"]
    }
}

class NullResponse: Mappable {
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
    }
}

class GetNewsResponse: Mappable {
    var items: [NewsItem]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        items <- map["items"]
    }
}
