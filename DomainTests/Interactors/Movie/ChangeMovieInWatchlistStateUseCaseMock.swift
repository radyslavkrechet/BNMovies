//
//  ChangeMovieInWatchlistStateUseCaseMock.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 14.01.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

@testable import Domain

class ChangeMovieInWatchlistStateUseCaseMock: ChangeMovieInWatchlistStateUseCaseProtocol {
    struct Settings {
        var shouldReturnError = false
    }

    struct Calls {
        var execute = false
    }

    var settings = Settings()
    var calls = Calls()

    func execute(with movie: Movie, handler: @escaping Handler<Movie>) {
        calls.execute = true
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.movie))
    }
}
