//
//  ChannelService.swift
//  channels
//
//  Created by Preet Shihn on 8/23/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation

class ChannelService {
    static let instance = ChannelService()
    
    private init() {
    }
    
    func register(address: String, publicKey: String, inviteCode: String?, callback: @escaping (RegisterResponse?, Error?) -> Void) {
        let details = RegisterUserDetails(address: address, publicKey: publicKey, inviteCode: inviteCode, timestamp: now())
        guard let signature = IdentityManager.instance.sign(details) else {
            callback(nil, ChannelsError.message("Failed to sign details"))
            return
        }
        let request = RestRequest<RegisterUserDetails>(details: details, signature: signature)
        RestService.Post("", body: request) { (response: RegisterResponse?, err: Error?) in
            if err != nil {
                callback(nil, err)
            } else {
                callback(response, nil)
            }
        }
    }
    
    private func now() -> Double {
        let timeInterval = Date().timeIntervalSince1970
        return Double(timeInterval * 1000)
    }
}
