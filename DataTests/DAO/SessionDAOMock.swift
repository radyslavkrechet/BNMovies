//
//  SessionDAOMock.swift
//  DataTests
//
//  Created by Radyslav Krechet on 28.11.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Data
import Domain

class SessionDAOMock: SessionDAOProtocol {
    struct Settings {
        var shouldReturnError = false
        var shouldReturnNil = false
    }

    struct Calls {
        var set = false
        var getSession = false
        var deleteSession = false
    }

    var settings = Settings()
    var calls = Calls()

    func set(_ session: Session, handler: @escaping Handler<Session>) {
        calls.set = true
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.session))
    }

    func getSession(handler: @escaping Handler<Session?>) {
        calls.getSession = true
        handler(settings.shouldReturnError
            ? .failure(Mock.Error.force)
            : .success(settings.shouldReturnNil ? nil : Mock.session))
    }

    func deleteSession(handler: @escaping Handler<Void>) {
        calls.deleteSession = true
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(()))
    }
}
