//
//  PunchcardDataReducer.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/1/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ReSwift

func punchcardDataReducer(action: Action, state: PunchcardDataState?) -> PunchcardDataState {
    // dummy implementation just to build
    return state ?? PunchcardDataState(jwt: nil, userId: 1, offerInstances: [], nearbyBusinesses: [])
}
