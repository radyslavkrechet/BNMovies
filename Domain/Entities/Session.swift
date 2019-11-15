//
//  Session.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

public struct Session {
    enum Error: Swift.Error {
        case noValue
    }

    public let token: String

    public init(token: String) {
        self.token = token
    }
}
