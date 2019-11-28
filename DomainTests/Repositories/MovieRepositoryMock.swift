//
//  MovieRepositoryMock.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 26.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

class MovieRepositoryMock: MovieRepositoryProtocol {
    struct Settings {
        var shouldReturnError = false
    }

    struct Calls {
        var getMovies = false
        var getFavourites = false
        var getMovie = false
        var getSimilarMovies = false
        var addToFavourites = false
        var deleteFromFavourites = false
    }

    struct Arguments {
        var page: Int?
        var id: String?
        var movie: Movie?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    private let movieMock = Movie(id: "id",
                                  title: "title",
                                  overview: "overview",
                                  posterSource: "posterSource",
                                  backdropSource: "backdropSource",
                                  runtime: 0,
                                  releaseDate: Date(),
                                  userScore: 0,
                                  genres: [Genre(id: "id", name: "name")],
                                  isFavourite: false)

    func getMovies(with page: Int, handler: @escaping Handler<[Movie]>) {
        calls.getMovies = true
        arguments.page = page
        movies(handler: handler)
    }

    func getFavourites(handler: @escaping Handler<[Movie]>) {
        calls.getFavourites = true
        movies(handler: handler)
    }

    func getMovie(with id: String, handler: @escaping Handler<Movie>) {
        calls.getMovie = true
        arguments.id = id
        movie(handler: handler)
    }

    func getSimilarMovies(_ id: String, handler: @escaping Handler<[Movie]>) {
        calls.getSimilarMovies = true
        arguments.id = id
        movies(handler: handler)
    }

    func addToFavourites(_ movie: Movie, handler: @escaping Handler<Movie>) {
        calls.addToFavourites = true
        arguments.movie = movie
        self.movie(handler: handler)
    }

    func deleteFromFavourites(_ movie: Movie, handler: @escaping Handler<Movie>) {
        calls.deleteFromFavourites = true
        arguments.movie = movie
        self.movie(handler: handler)
    }

    private func movies(handler: @escaping Handler<[Movie]>) {
        handler(settings.shouldReturnError ? .failure(MockError.force) : .success([]))
    }

    private func movie(handler: @escaping Handler<Movie>) {
        handler(settings.shouldReturnError ? .failure(MockError.force) : .success(movieMock))
    }
}
