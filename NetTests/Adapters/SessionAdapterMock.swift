//
//  SessionAdapterMock.swift
//  NetTests
//
//  Created by Radyslav Krechet on 02.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Net

private enum Mock {
    static var session: Session {
        Session(id: "id", token: "token")
    }
}

class SessionAdapterMock: SessionAdapterProtocol {
    struct Calls {
        var toEntity = false
    }

    var calls = Calls()

    func toEntity(_ response: CreateSessionResponse) -> Session {
        calls.toEntity = true
        return Mock.session
    }
}
