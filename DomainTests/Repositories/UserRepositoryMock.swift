//
//  UserRepositoryMock.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 26.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Mock

class UserRepositoryMock: UserRepositoryProtocol {
    struct Settings {
        var shouldReturnError = false
    }

    struct Calls {
        var getUser = false
        var deleteUser = false
    }

    struct Arguments {
        var token: String?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    func getUser(with token: String, handler: @escaping Handler<User>) {
        calls.getUser = true
        arguments.token = token
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.user))
    }

    func deleteUser(handler: @escaping Handler<Void>) {
        calls.deleteUser = true
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(()))
    }
}
