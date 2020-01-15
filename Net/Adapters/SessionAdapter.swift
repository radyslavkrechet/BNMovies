//
//  SessionAdapter.swift
//  Net
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

protocol SessionAdapterProtocol {
    func toObject(_ response: CreateSessionResponse) -> Session
}

struct SessionAdapter: SessionAdapterProtocol {
    func toObject(_ response: CreateSessionResponse) -> Session {
        return Session(id: response.sessionId, token: response.sessionId)
    }
}
