//
//  SignInState.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 18.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

enum SignInState: Equatable {
    case loading, error(_ error: Error)

    static func == (lhs: SignInState, rhs: SignInState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.error, .error):
            return true
        default:
            return false
        }
    }
}
