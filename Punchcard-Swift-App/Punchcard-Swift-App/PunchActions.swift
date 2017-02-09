//
//  PunchActions.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/8/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ReSwift
import Alamofire
import ObjectMapper

struct PostPunch: Action {
    let punchResult: Result<Punch>?
}

func postPunch(parameters: [String: AnyObject]) -> Store<RootState>.ActionCreator {
    return { state, store in
        
        Alamofire.request(PunchRouter.create(parameters)).responseJSON { response in
            guard let json = response.result.value else {
                // Error
                let apiError = APIError(status: response.response?.statusCode ?? 400, error: response.result.error?.localizedDescription ?? "Invalid code")
                store.dispatch(PostPunch(punchResult: Result.Failure(apiError)))
                return
            }
            // TODO: - Check the below status code (201) is correct.
            guard response.response?.statusCode == StatusCode.punchSuccessful.rawValue else {
                // Error
                let apiError = Mapper<APIError>().map(JSONObject: json)!
                store.dispatch(PostPunch(punchResult: Result.Failure(apiError)))
                return
            }
            if let punchResult = Mapper<Punch>().map(JSONObject: json) {
                store.dispatch(PostPunch(punchResult: Result.Success(punchResult)))
            } else {
                print("couldn't map punch result from api result")
            }
        }
        
        return PostPunch(punchResult: Result.Loading())
    }
}
