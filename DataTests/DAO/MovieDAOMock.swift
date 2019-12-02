//
//  MovieDAOMock.swift
//  DataTests
//
//  Created by Radyslav Krechet on 28.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Data
import Domain

private enum Mock {
    enum Error: Swift.Error {
        case force
    }

    static var movies: [Movie] {
        []
    }

    static var movie: Movie {
        Movie(id: "id",
              title: "title",
              overview: "overview",
              posterSource: "posterSource",
              backdropSource: "backdropSource",
              runtime: 0,
              releaseDate: Date(),
              userScore: 0,
              genres: [genre],
              isFavourite: false)
    }

    static var genre: Genre {
        Genre(id: "id", name: "name")
    }
}

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
        handler(shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.movies))
    }

    func getMovie(with id: String, handler: @escaping Handler<Movie?>) {
        run()
        calls.getMovie = true
        handler(shouldReturnError
            ? .failure(Mock.Error.force)
            : .success(settings.shouldReturnNil ? nil : settings.movie))
    }

    private func run() {
        runIndex += 1
    }
}
