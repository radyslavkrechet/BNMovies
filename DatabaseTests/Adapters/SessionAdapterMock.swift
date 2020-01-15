//
//  SessionAdapterMock.swift
//  DatabaseTests
//
//  Created by Radyslav Krechet on 04.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Database

class SessionAdapterMock: SessionAdapterProtocol {
    struct Calls {
        var fromStorage = false
        var toStorage = false
    }

    var calls = Calls()

    func fromStorage(_ entity: SessionEntity) -> Session {
        calls.fromStorage = true
        return Mock.sessionObject
    }

    func toStorage(_ object: Session, _ entity: SessionEntity) -> SessionEntity {
        calls.toStorage = true
        return Mock.sessionEntity
    }
}
