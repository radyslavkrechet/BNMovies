//
//  UserAPIMock.swift
//  DataTests
//
//  Created by Radyslav Krechet on 28.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Data
import Domain
import Mock

class UserAPIMock: UserAPIProtocol {
    struct Settings {
        var shouldReturnError = false
    }

    struct Calls {
        var getUser = false
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
}
