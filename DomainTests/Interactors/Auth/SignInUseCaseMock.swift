//
//  SignInUseCaseMock.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

@testable import Domain

class SignInUseCaseMock: SignInUseCaseProtocol {
    struct Settings {
        var shouldReturnError = false
    }

    struct Calls {
        var execute = false
    }

    struct Arguments {
        var username: String?
        var password: String?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    func execute(with username: String, password: String, handler: @escaping Handler<User>) {
        calls.execute = true
        arguments.username = username
        arguments.password = password
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.user))
    }
}
