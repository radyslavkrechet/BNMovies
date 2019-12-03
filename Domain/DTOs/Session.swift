//
//  Session.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public struct Session: Identifiable {
    enum Error: Swift.Error {
        case noValue
    }

    public let id: String
    public let token: String

    public init(id: String, token: String) {
        self.id = id
        self.token = token
    }
}
