//
//  MockSettings.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 26.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

enum MockSettings {
    case failure
    case success(isTruthy: Bool) // set 'true' for not nil (optionals), true (booleans)
}
