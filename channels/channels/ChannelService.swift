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
    
    var accountStatus: AccountStatus? {
        get {
            return self.registration?.status
        }
    }
    
    private func now() -> Int64 {
        let timeInterval = Date().timeIntervalSince1970
        return Int64(timeInterval * 1000)
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
    
    func registerDevice(token: String, callback: @escaping (Error?) -> Void) {
        let details = RegisterDeviceDetails(address: IdentityManager.instance.userAddress, token: token, timestamp: now())
        guard let request = CoreUtils.restRequestFor(data: details) else {
            callback(ChannelsError.message("Failed to sign and create request"))
            return
        }
        let url = restRoot + "/register-ios-device"
        RestService.Post(url, body: request) { (_: NullResponse?, err: Error?) in
            callback(err)
        }
    }
    
    func updateIdentity(_ identity: UserIdentity, callback: @escaping (Error?) -> Void) {
        let details = UpdateIdentityDetails(address: identity.address!, name: identity.name!, handle: identity.handle!, location: identity.location, timestamp: now())
        guard let request = CoreUtils.restRequestFor(data: details) else {
            callback(ChannelsError.message("Failed to sign and create request"))
            return
        }
        let url = restRoot + "/update-identity"
        RestService.Post(url, body: request) { (_: NullResponse?, err: Error?) in
            callback(err)
        }
    }
    
    func getUserIdentity(callback: @escaping (GetUserIdentityResponse?, Error?) -> Void) {
        let details = GetUserIdentityDetails(address: IdentityManager.instance.userAddress, timestamp: now())
        guard let request = CoreUtils.restRequestFor(data: details) else {
            callback(nil, ChannelsError.message("Failed to sign and create request"))
            return
        }
        let url = restRoot + "/get-identity"
        RestService.Post(url, body: request) { (response: GetUserIdentityResponse?, err: Error?) in
            callback(response, err)
        }
    }
    
    func getNews(callback: @escaping (GetNewsResponse?, Error?) -> Void) {
        let details = GetNewsDetails(address: IdentityManager.instance.userAddress, maxCount: 50, timestamp: now())
        guard let request = CoreUtils.restRequestFor(data: details) else {
            callback(nil, ChannelsError.message("Failed to sign and create getNews request"))
            return
        }
        let url = restRoot + "/get-news";
        RestService.Post(url, body: request) { (response: GetNewsResponse?, err: Error?) in
            callback(response, err)
        }
    }
}
