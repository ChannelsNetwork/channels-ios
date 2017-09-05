//
//  NewsItem.swift
//  channels
//
//  Created by Preet Shihn on 9/5/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation
import ObjectMapper

class NewsItem: Mappable {
    var id: String?
    var timestamp: Int64?
    var title: String?
    var text: String?
    var imageUrl: String?
    var linkUrl: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        timestamp   <- (map["timestamp"], CoreUtils.transformInt64)
        title       <- map["title"]
        text        <- map["text"]
        imageUrl    <- map["imageUrl"]
        linkUrl     <- map["linkUrl"]
    }
}
