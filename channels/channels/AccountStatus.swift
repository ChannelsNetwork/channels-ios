//
//  AccountStatus.swift
//  channels
//
//  Created by Preet Shihn on 8/23/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation
import ObjectMapper

class AccountStatus: Mappable {
    var goLive: Int = 0
    var userBalance: Double = 0
    var networkBalance: Int = 0
    var invitationsUsed: Int = 0
    var invitationsRemaining: Int = 0
    var inviterRewards: Int = 0
    var inviteeReward: Int = 0
    var inviteCode: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        goLive                  <- map["goLive"]
        userBalance             <- map["userBalance"]
        networkBalance          <- map["networkBalance"]
        invitationsUsed         <- map["invitationsUsed"]
        invitationsRemaining    <- map["invitationsRemaining"]
        inviterRewards          <- map["inviterRewards"]
        inviteeReward           <- map["inviteeReward"]
        inviteCode              <- map["inviteCode"]
    }
}
