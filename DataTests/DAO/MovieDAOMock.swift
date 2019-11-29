//
//  MovieDAOMock.swift
//  DataTests
//
//  Created by Radyslav Krechet on 28.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Data
import Domain
import Mock

class MovieDAOMock: MovieDAOProtocol {
    struct Settings {
        var shouldReturnError = false
        var errorIndex = 0
        var shouldReturnNil = false
        var movie = Mock.movie
    }

    struct Calls {
        var set = false
        var getFavourites = false
        var getMovie = false
    }

    struct Arguments {
        var movie: Movie?
        var id: String?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    private var runIndex = -1
    private var shouldReturnError: Bool { settings.shouldReturnError && settings.errorIndex == runIndex }

    func set(_ movie: Movie, handler: @escaping Handler<Movie>) {
        run()
        calls.set = true
        arguments.movie = movie
        handler(shouldReturnError ? .failure(Mock.Error.force) : .success(settings.movie))
    }

    func getFavourites(handler: @escaping Handler<[Movie]>) {
        run()
        calls.getFavourites = true
        handler(shouldReturnError ? .failure(Mock.Error.force) : .success([]))
    }

    func getMovie(with id: String, handler: @escaping Handler<Movie?>) {
        run()
        calls.getMovie = true
        arguments.id = id
        handler(shouldReturnError
            ? .failure(Mock.Error.force)
            : .success(settings.shouldReturnNil ? nil : settings.movie))
    }

    private func run() {
        runIndex += 1
    }
}
