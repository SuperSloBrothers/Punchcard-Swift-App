//
//  Token.swift
//  Punchcard-Swift-App
//
//  Created by Amir Saifi on 2/3/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ObjectMapper

struct Token: Mappable {
    var token: String!
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        token       <- map["token"]
    }
}
