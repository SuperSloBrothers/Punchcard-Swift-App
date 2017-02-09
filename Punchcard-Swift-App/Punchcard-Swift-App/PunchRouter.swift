//
//  PunchRouter.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/8/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import Alamofire

enum PunchRouter: URLRequestConvertible {
    static let baseUrlString = "https://punchcard-app.herokuapp.com/api/"
    static let endpointString = "punches/"
    static var oAuthToken: String?
    
    case create([String: AnyObject])
    case read(String?, [String: AnyObject]?)
    case update(String, [String: AnyObject])
    case delete(String)
    
    var method: HTTPMethod {
        switch self {
        case .create: return .post
        case .read: return .get
        case .update: return .patch
        case .delete: return .delete
        }
    }
    
    var path: String {
        switch self {
        case .create:
            return PunchRouter.endpointString
        case .read(.some(let id), _):
            return PunchRouter.endpointString + id
        case .read(.none, _):
            return PunchRouter.endpointString
        case .update(let id, _):
            return PunchRouter.endpointString + id
        case .delete(let id):
            return PunchRouter.endpointString + id
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: PunchRouter.baseUrlString)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        if let token = PunchRouter.oAuthToken {
            urlRequest.setValue("JWT \(token)", forHTTPHeaderField: "Authorization")
        }
        
        switch self {
        case .create(let parameters):
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: parameters)
        case .update(_, let parameters):
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: parameters)
        case .read(_, .some(let parameters)):
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
        case .read(_, .none):
            return urlRequest
        case .delete:
            return urlRequest
        }
    }
}
