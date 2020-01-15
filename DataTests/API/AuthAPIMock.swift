//
//  AuthAPIMock.swift
//  DataTests
//
//  Created by Radyslav Krechet on 28.11.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Data
import Domain

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
