//
//  BusinessActions.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/8/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ReSwift
import Alamofire
import ObjectMapper

struct SetBusinesses: Action {
    let businesses: Result<[Business]>?
}

func getBusinesses(parameters: [String: AnyObject]? = nil) -> Store<RootState>.ActionCreator {
    return { state, store in
        
        Alamofire.request(BusinessRouter.read(nil, parameters)).responseJSON { response in
            guard let json = response.result.value else {
                // Error
                let apiError = APIError(status: response.response?.statusCode ?? 400, error: response.result.error?.localizedDescription ?? "Error")
                store.dispatch(SetBusinesses(businesses: Result.Failure(apiError)))
                return
            }
            guard response.response?.statusCode == StatusCode.ok.rawValue else {
                // Error
                let apiError = Mapper<APIError>().map(JSONObject: json)!
                store.dispatch(SetBusinesses(businesses: Result.Failure(apiError)))
                return
            }
            if let businesses = Mapper<Business>().mapArray(JSONObject: json) {
                store.dispatch(SetBusinesses(businesses: Result.Success(businesses)))
            } else {
                print("couldn't map businesses from api result")
            }
        }
        
        return SetBusinesses(businesses: Result.Loading())
    }
}
