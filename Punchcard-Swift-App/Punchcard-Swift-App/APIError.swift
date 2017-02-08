//
//  APIError.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/8/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ObjectMapper

struct APIError: Mappable, Error {
    var status: Int!
    var type: String!
    var message: String!
    
    init(status: Int, type: String, message: String) {
        self.status = status
        self.type = type
        self.message = message
    }
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        status  <- map["status"]
        type    <- map["type"]
        message <- map["message"]
    }
}
