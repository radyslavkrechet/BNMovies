//
//  SessionAdapter.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain

enum SessionAdapter {
    static func toEntity(_ response: CreateSessionResponse) -> Session {
        return Session(token: response.sessionId)
    }
}
