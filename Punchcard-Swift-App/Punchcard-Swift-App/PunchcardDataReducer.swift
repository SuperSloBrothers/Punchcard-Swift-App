//
//  PunchcardDataReducer.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/1/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ReSwift

func createInitialPunchcardDataState() -> PunchcardDataState {
    return PunchcardDataState(
        offerInstances: nil,
        nearbyBusinesses: nil
    )
}

func punchcardDataReducer(action: Action, state: PunchcardDataState?) -> PunchcardDataState {
    var state = state ?? createInitialPunchcardDataState()
    
    switch action {
    case let action as SetBusinesses:
        state.nearbyBusinesses = action.businesses
    default:
        break
    }
    
    return state
}
