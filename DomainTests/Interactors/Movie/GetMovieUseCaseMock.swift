//
//  GetMovieUseCaseMock.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

@testable import Domain

class GetMovieUseCaseMock: GetMovieUseCaseProtocol {
    struct Settings {
        var shouldReturnError = false
    }

    struct Calls {
        var execute = false
    }

    struct Arguments {
        var id: String?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    func execute(with id: String, handler: @escaping Handler<Movie>) {
        calls.execute = true
        arguments.id = id
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.movie))
    }
}
