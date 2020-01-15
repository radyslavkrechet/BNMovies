//
//  MovieRepositoryMock.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 26.11.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

class MovieRepositoryMock: MovieRepositoryProtocol {
    struct Settings {
        var shouldReturnError = false
    }

    struct Calls {
        var getChart = false
        var getCollection = false
        var getMovie = false
        var getSimilarMovies = false
        var toggleMovieCollection = false
    }

    struct Arguments {
        var chart: Movie.Chart?
        var page: Int?
        var collection: Movie.Collection?
        var id: String?
        var movie: Movie?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    func getChart(_ chart: Movie.Chart, page: Int, handler: @escaping Handler<[Movie]>) {
        calls.getChart = true
        arguments.chart = chart
        arguments.page = page
        movies(handler: handler)
    }

    func getCollection(_ collection: Movie.Collection, handler: @escaping Handler<[Movie]>) {
        calls.getCollection = true
        arguments.collection = collection
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

    func toggleMovieCollection(_ movie: Movie, collection: Movie.Collection, handler: @escaping Handler<Movie>) {
        calls.toggleMovieCollection = true
        arguments.movie = movie
        arguments.collection = collection
        self.movie(handler: handler)
    }

    private func movies(handler: @escaping Handler<[Movie]>) {
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success([]))
    }

    private func movie(handler: @escaping Handler<Movie>) {
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.movie))
    }
}
