//
//  AuthAPIMock.swift
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
        Session(id: "id", token: "token")
    }
}

class AuthAPIMock: AuthAPIProtocol {
    struct Settings {
        var shouldReturnError = false
    }

    struct Calls {
        var signIn = false
    }

    struct Arguments {
        var username: String?
        var password: String?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    func signIn(with username: String, password: String, handler: @escaping Handler<Session>) {
        calls.signIn = true
        arguments.username = username
        arguments.password = password
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.session))
    }
}
