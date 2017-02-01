//
//  RootStateReducer.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/1/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ReSwift

struct RootStateReducer: Reducer {
    
    // Delegate to sub-reducers.
    func handleAction(action: Action, state: RootState?) -> RootState {
        return RootState(
            applicationSettings: applicationSettingsReducer(action: action, state: state?.applicationSettings),
            punchcardData: punchcardDataReducer(action: action, state: state?.punchcardData)
        )
    }
    
}
