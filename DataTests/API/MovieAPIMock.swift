//
//  MovieAPIMock.swift
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

class MovieAPIMock: MovieAPIProtocol {
    struct Settings {
        var shouldReturnError = false
        var movie = Mock.movie
    }

    struct Calls {
        var getMovies = false
        var getMovie = false
        var getSimilarMovies = false
    }

    struct Arguments {
        var page: Int?
        var id: String?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    func getMovies(with page: Int, handler: @escaping Handler<[Movie]>) {
        calls.getMovies = true
        arguments.page = page
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.movies))
    }

    func getMovie(with id: String, handler: @escaping Handler<Movie>) {
        calls.getMovie = true
        arguments.id = id
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(settings.movie))
    }

    func getSimilarMovies(_ id: String, handler: @escaping Handler<[Movie]>) {
        calls.getSimilarMovies = true
        arguments.id = id
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.movies))
    }
}
