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
    
    private let restRoot: String
    private var registration: RegisterResponse? = nil
    
    private init() {
        let serverUrl = Config.get(Config.kServerUrl) ?? "http://localhost:33111"
        restRoot = serverUrl + "/d"
    }
    
    func register(inviteCode: String?, callback: @escaping (RegisterResponse?, Error?) -> Void) {
        if (self.registration != nil) {
            callback(self.registration, nil)
            return
        }
        let im  = IdentityManager.instance
        let details = RegisterUserDetails(address: im.userAddress, publicKey: im.publicKey, inviteCode: inviteCode, timestamp: now())
        guard let request = CoreUtils.restRequestFor(data: details) else {
            callback(nil, ChannelsError.message("Failed to sign and create request"))
            return
        }
        let url = restRoot + "/register-user"
        RestService.Post(url, body: request) { (response: RegisterResponse?, err: Error?) in
            if err != nil {
                callback(nil, err)
            } else {
                self.registration = response
                callback(response, nil)
            }
        }
    }
    
    private func now() -> Int {
        let timeInterval = Date().timeIntervalSince1970
        return Int(timeInterval * 1000)
    }
}
