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
    var error: String!
    var status: Int!
    // TODO: - Is `status` an Int or wat
    
    init(status: Int, error: String) {
        self.error = error
        self.status = status
    }
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        error   <- map["error"]
        status  <- map["status"]
    }
}
