//
//  OfferActions.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/8/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ReSwift
import Alamofire
import ObjectMapper

struct CreateOffer: Action {
    let offerResult: Result<Offer>?
}

func postOffer(parameters: [String: AnyObject]) -> Store<RootState>.ActionCreator {
    return { state, store in
        
        Alamofire.request(OfferRouter.create(parameters)).responseJSON { response in
            guard let json = response.result.value else {
                // Error
                let apiError = APIError(status: response.response?.statusCode ?? 400, error: response.result.error?.localizedDescription ?? "Error")
                store.dispatch(CreateOffer(offerResult: Result.Failure(apiError)))
                return
            }
            // TODO: - Check the below status code (200) is correct.
            guard response.response?.statusCode == StatusCode.ok.rawValue else {
                // Error
                let apiError = Mapper<APIError>().map(JSONObject: json)!
                store.dispatch(CreateOffer(offerResult: Result.Failure(apiError)))
                return
            }
            if let offer = Mapper<Offer>().map(JSONObject: json) {
                store.dispatch(CreateOffer(offerResult: Result.Success(offer)))
            } else {
                print("couldn't map offer instances from api result")
            }
        }
        
        return CreateOffer(offerResult: Result.Loading())
    }
}
