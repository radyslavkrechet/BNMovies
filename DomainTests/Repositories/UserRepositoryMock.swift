//
//  UserRepositoryMock.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 26.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

private enum Mock {
    enum Error: Swift.Error {
        case force
    }

    static var user: User {
        User(id: "id", username: "username", name: "name", avatarSource: "avatarSource")
    }
}

class UserRepositoryMock: UserRepositoryProtocol {
    struct Settings {
        var shouldReturnError = false
    }

    struct Calls {
        var getUser = false
        var deleteUser = false
    }

    var settings = Settings()
    var calls = Calls()

    func getUser(with token: String, handler: @escaping Handler<User>) {
        calls.getUser = true
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.user))
    }

    func deleteUser(handler: @escaping Handler<Void>) {
        calls.deleteUser = true
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(()))
    }
}
