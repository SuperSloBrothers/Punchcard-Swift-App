//
//  ApplicationSettingsActions.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/1/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ReSwift
import SwiftyUserDefaults
import Alamofire
import ObjectMapper

struct ResetUserState: Action {}

struct SetApiToken: Action {
    let token: String!
}

func requestAPIToken (completion: @escaping (Bool) -> ()) {
    
    Defaults[.apiToken] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3QiLCJ1c2VyX2lkIjoyLCJlbWFpbCI6IiIsImV4cCI6MTQ0ODIyNDQxNn0.Fy74xruQgnU8wevEx5dGUkFDmCcTj9hfDefYutdvapE"
    completion(true)
    return
    
    let alamoRequest = Alamofire.request("https://punchcard-app.herokuapp.com/api/users/auth")
    alamoRequest.responseJSON { response in
        guard let JSON = response.result.value else {
            print("error with api token request")
            completion(false)
            return
        }
        if let token = Mapper<Token>().map(JSONObject: JSON) {
            // we probably won't put the token in the state like this
            // only have it this way so the state isn't completely empty for now :)
            store.dispatch(SetApiToken(token: token.token))
            Defaults[.apiToken] = token.token
            print("woohoo we got the token!\ntoken:\(token.token)")
            completion(true)
        } else {
            completion(false)
        }
    }
}
