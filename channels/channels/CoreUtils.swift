//
//  CoreUtils.swift
//  channels
//
//  Created by Preet Shihn on 8/24/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation
import ObjectMapper

class CoreUtils {
    static func restRequestFor(data: Mappable) -> RestRequest? {
        guard let json = data.toJSONString() else {
            return nil
        }
        guard let signature = IdentityManager.instance.sign(json) else {
            return nil
        }
        return RestRequest(details: json, signature: signature)
    }
    
    static let transformInt64 = TransformOf<Int64, Double>(fromJSON: { (value: Double?) -> Int64? in
        guard let v = value else {
            return nil
        }
        return Int64(v)
    }) { (value: Int64?) -> Double? in
        guard let v = value else {
            return nil
        }
        return Double(v)
    }
}
