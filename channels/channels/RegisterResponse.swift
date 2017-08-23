//
//  RegisterResponse.swift
//  channels
//
//  Created by Preet Shihn on 8/23/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation

class RegisterResponse: Serializable {
    var status: AccountStatus?
    
    required init?(json: [String : Any]) throws {
        guard let statusJson = json["status"] as? [String: Any] else {
            throw SerializationError.missing("status")
        }
        self.status = try AccountStatus(json: statusJson)
    }
}
