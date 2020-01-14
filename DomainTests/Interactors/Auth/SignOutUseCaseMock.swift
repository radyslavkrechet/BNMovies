//
//  SignOutUseCaseMock.swift
//  MoviesTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

@testable import Domain

class SignOutUseCaseMock: SignOutUseCaseProtocol {
    struct Settings {
        var shouldReturnError = false
    }

    struct Calls {
        var execute = false
    }

    var settings = Settings()
    var calls = Calls()

    func execute(_ handler: @escaping Handler<Void>) {
        calls.execute = true
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(()))
    }
}
