//
//  SessionAdapterMock.swift
//  NetTests
//
//  Created by Radyslav Krechet on 02.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Net

class SessionAdapterMock: SessionAdapterProtocol {
    struct Calls {
        var toObject = false
    }

    var calls = Calls()

    func toObject(_ response: CreateSessionResponse) -> Session {
        calls.toObject = true
        return Mock.session
    }
}
