//
//  SignInAPIMock.swift
//  NetTests
//
//  Created by Radyslav Krechet on 02.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Net

class SignInAPIMock: SignInAPIProtocol {
    struct Settings {
        var shouldReturnError = false
        var errorIndex = 0
    }

    struct Calls {
        var createToken = false
        var validate = false
        var createSession = false
    }

    struct Arguments {
        var username: String?
        var password: String?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    private var runIndex = -1
    private var shouldReturnError: Bool { settings.shouldReturnError && settings.errorIndex == runIndex }

    func createToken(handler: @escaping Handler<String>) {
        run()
        calls.createToken = true
        handler(shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.token))
    }

    func validate(requestToken: String, username: String, password: String, handler: @escaping Handler<String>) {
        run()
        calls.validate = true
        arguments.username = username
        arguments.password = password
        handler(shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.token))
    }

    func createSession(with requestToken: String, handler: @escaping Handler<Session>) {
        run()
        calls.createSession = true
        handler(shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.session))
    }

    private func run() {
        runIndex += 1
    }
}
