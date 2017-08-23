//
//  RegisterResponse.swift
//  channels
//
//  Created by Preet Shihn on 8/23/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation
import ObjectMapper

class RegisterResponse: Mappable {
    var status: AccountStatus?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status  <- map["status"]
    }
}
