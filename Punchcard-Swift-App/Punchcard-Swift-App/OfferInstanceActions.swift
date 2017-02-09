//
//  OfferInstanceActions.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/8/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ReSwift
import Alamofire
import ObjectMapper

struct SetOfferInstances: Action {
    let offerInstances: Result<[OfferInstance]>?
}

func getOfferInstances(parameters: [String: AnyObject]? = nil) -> Store<RootState>.ActionCreator {
    return { state, store in
        
        Alamofire.request(OfferInstanceRouter.read(nil, parameters)).responseJSON { response in
            guard let json = response.result.value else {
                // Error
                let apiError = APIError(status: response.response?.statusCode ?? 400, error: response.result.error?.localizedDescription ?? "Error")
                store.dispatch(SetOfferInstances(offerInstances: Result.Failure(apiError)))
                return
            }
            guard response.response?.statusCode == StatusCode.ok.rawValue else {
                // Error
                let apiError = Mapper<APIError>().map(JSONObject: json)!
                store.dispatch(SetOfferInstances(offerInstances: Result.Failure(apiError)))
                return
            }
            if let offerInstances = Mapper<OfferInstance>().mapArray(JSONObject: json) {
                store.dispatch(SetOfferInstances(offerInstances: Result.Success(offerInstances)))
            } else {
                print("couldn't map offer instances from api result")
            }
        }
        
        return SetOfferInstances(offerInstances: Result.Loading())
    }
}
