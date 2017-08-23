//
//  Serializable.swift
//  channels
//
//  Created by Preet Shihn on 8/23/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation

protocol Serializable {
    init?(json: [String: Any]) throws
    func dictify() -> [String: Any]
    func stringify() -> String?
}

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}
