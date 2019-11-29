//
//  UserDAOMock.swift
//  DataTests
//
//  Created by Radyslav Krechet on 28.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Data
import Domain
import Mock

class UserDAOMock: UserDAOProtocol {
    struct Settings {
        var shouldReturnError = false
        var errorIndex = 0
        var shouldReturnNil = false
    }

    struct Calls {
        var set = false
        var getUser = false
        var deleteUser = false
    }

    struct Arguments {
        var user: User?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    private var runIndex = -1
    private var shouldReturnError: Bool { settings.shouldReturnError && settings.errorIndex == runIndex }

    func set(_ user: User, handler: @escaping Handler<User>) {
        run()
        calls.set = true
        arguments.user = user
        handler(shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.user))
    }

    func getUser(handler: @escaping Handler<User?>) {
        run()
        calls.getUser = true
        handler(shouldReturnError ? .failure(Mock.Error.force) : .success(settings.shouldReturnNil ? nil : Mock.user))
    }

    func deleteUser(handler: @escaping Handler<Void>) {
        run()
        calls.deleteUser = true
        handler(shouldReturnError ? .failure(Mock.Error.force) : .success(()))
    }

    private func run() {
        runIndex += 1
    }
}
