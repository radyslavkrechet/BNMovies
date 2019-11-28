//
//  AuthRepositoryMock.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 26.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

class AuthRepositoryMock: AuthRepositoryProtocol {
    struct Settings {
        var shouldReturnError = false
        var shouldReturnNil = false
        var shouldReturnTrue = false
    }

    struct Calls {
        var signIn = false
        var getSession = false
        var isSignedIn = false
        var signOut = false
    }

    struct Arguments {
        var username: String?
        var password: String?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    private let sessionMock = Session(token: "token")

    func signIn(with username: String, password: String, handler: @escaping Handler<Session>) {
        calls.signIn = true
        arguments.username = username
        arguments.password = password
        handler(settings.shouldReturnError ? .failure(MockError.force) : .success(sessionMock))
    }

    func getSession(handler: @escaping Handler<Session?>) {
        calls.getSession = true
        handler(settings.shouldReturnError
            ? .failure(MockError.force)
            : .success(settings.shouldReturnNil ? nil : sessionMock))
    }

    func isSignedIn(handler: @escaping Handler<Bool>) {
        calls.isSignedIn = true
        handler(settings.shouldReturnError ? .failure(MockError.force) : .success(settings.shouldReturnTrue))
    }

    func signOut(handler: @escaping Handler<Void>) {
        calls.signOut = true
        handler(settings.shouldReturnError ? .failure(MockError.force) : .success(()))
    }
}
