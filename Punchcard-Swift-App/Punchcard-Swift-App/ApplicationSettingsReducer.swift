//
//  ApplicationSettingsReducer.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/1/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ReSwift
import SwiftyUserDefaults

func createInitialApplicationSettingsState() -> ApplicationSettingsState {
    let state = ApplicationSettingsState(
        userApiToken: Defaults[.apiToken]
    )
    
    return state
}

func applicationSettingsReducer(action: Action, state: ApplicationSettingsState?) -> ApplicationSettingsState {
    var state = state ?? createInitialApplicationSettingsState()
    
    switch action {
    case let action as SetApiToken:
        state.userApiToken = action.token
        BusinessRouter.oAuthToken = action.token
        OfferInstanceRouter.oAuthToken = action.token
        PunchRouter.oAuthToken = action.token
    default:
        break
    }
    
    return state
}
