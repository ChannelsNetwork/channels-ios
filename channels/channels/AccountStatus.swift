//
//  AccountStatus.swift
//  channels
//
//  Created by Preet Shihn on 8/23/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation

class AccountStatus: Serializable {
    var goLive: Int64 = 0
    var userBalance: Int = 0
    var networkBalance: Int = 0
    var inviteCode: String?
    var invitationsUsed: Int = 0
    var invitationsRemaining: Int = 0
    var inviterRewards: Int = 0
    var inviteeReward: Int = 0
    
    required init?(json: [String : Any]) throws {
        guard let goLive = json["goLive"] as? Int64 else {
            throw SerializationError.missing("goLive")
        }
        guard let userBalance = json["userBalance"] as? Int else {
            throw SerializationError.missing("userBalance")
        }
        guard let networkBalance = json["networkBalance"] as? Int else {
            throw SerializationError.missing("networkBalance")
        }
        guard let invitationsUsed = json["invitationsUsed"] as? Int else {
            throw SerializationError.missing("invitationsUsed")
        }
        guard let invitationsRemaining = json["invitationsRemaining"] as? Int else {
            throw SerializationError.missing("invitationsRemaining")
        }
        guard let inviterRewards = json["inviterRewards"] as? Int else {
            throw SerializationError.missing("inviterRewards")
        }
        guard let inviteeReward = json["inviteeReward"] as? Int else {
            throw SerializationError.missing("inviteeReward")
        }
        let inviteCode = json["inviteCode"] as? String
        
        self.goLive = goLive
        self.userBalance = userBalance
        self.networkBalance = networkBalance
        self.invitationsUsed = invitationsUsed
        self.invitationsRemaining = invitationsRemaining
        self.inviterRewards = inviterRewards
        self.inviteeReward = inviteeReward
        self.inviteCode = inviteCode
    }
    
    func dictify() -> [String: Any] {
        var dict: [String: Any] = [
            "goLive": self.goLive,
            "userBalance": self.userBalance,
            "networkBalance": self.networkBalance,
            "invitationsUsed": self.invitationsUsed,
            "invitationsRemaining": self.invitationsRemaining,
            "inviterRewards": self.inviterRewards,
            "inviteeReward": self.inviteeReward
        ]
        if (self.inviteCode != nil) {
            dict["inviteCode"] = self.inviteCode
        }
        return dict
    }
    
    func stringify() -> String? {
        return nil
    }
    
}
