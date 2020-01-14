//
//  GetMovieUseCaseMock.swift
//  MoviesTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

@testable import Domain

class GetMovieUseCaseMock: GetMovieUseCaseProtocol {
    struct Settings {
        var shouldReturnError = false
        var movie = Mock.movie
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
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(settings.movie))
    }
}
