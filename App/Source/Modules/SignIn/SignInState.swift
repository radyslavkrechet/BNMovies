//
//  SignInState.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 18.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

enum SignInState {
    case loading, error(_ error: Error)
}
