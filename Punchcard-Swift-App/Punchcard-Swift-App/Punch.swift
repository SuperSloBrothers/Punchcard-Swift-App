//
//  Punch.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/8/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ObjectMapper

struct Punch: Mappable {
    
    var id: Int!
    var user: Int?
    var timestamp: String?
    var offer: Int!
    var offerInstance: Int!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id              <- map["id"]
        user            <- map["user"]
        timestamp       <- map["timestamp"]
        offer           <- map["offer"]
        offerInstance   <- map["offer_instance"]
    }
    
}
