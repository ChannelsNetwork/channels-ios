//
//  UserIdentity.swift
//  channels
//
//  Created by Preet Shihn on 8/21/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation

class UserIdentity: NSObject, NSCoding {
    var address: String
    var name: String
    var handle: String
    var timestamp: Int64
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveUrl = DocumentsDirectory.appendingPathComponent("user-identity")
    
    struct PropertyKey {
        static let name = "name"
        static let address = "address"
        static let handle = "handle"
        static let timestamp = "timestamp"
    }
    
    init(name: String, address: String, handle: String, timestamp: Int64?) {
        self.name = name
        self.address = address
        self.handle = handle
        if timestamp != nil {
            self.timestamp = timestamp!
        } else {
            let timeInterval = Date().timeIntervalSince1970
            self.timestamp = Int64(timeInterval * 1000)
        }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            return nil
        }
        guard let address = aDecoder.decodeObject(forKey: PropertyKey.address) as? String else {
            return nil
        }
        guard let handle = aDecoder.decodeObject(forKey: PropertyKey.handle) as? String else {
            return nil
        }
        guard let timestamp = aDecoder.decodeObject(forKey: PropertyKey.timestamp) as? Int64 else {
            return nil
        }
        self.init(name: name, address: address, handle: handle, timestamp: timestamp)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(address, forKey: PropertyKey.address)
        aCoder.encode(handle, forKey: PropertyKey.handle)
        aCoder.encode(timestamp, forKey: PropertyKey.timestamp)
    }
}
