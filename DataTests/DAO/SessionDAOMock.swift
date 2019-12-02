//
//  SessionDAOMock.swift
//  DataTests
//
//  Created by Radyslav Krechet on 28.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Data
import Domain

private enum Mock {
    enum Error: Swift.Error {
        case force
    }

    static var session: Session {
        Session(token: "token")
    }
}

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

    struct Arguments {
        var session: Session?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    func set(_ session: Session, handler: @escaping Handler<Session>) {
        calls.set = true
        arguments.session = session
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
