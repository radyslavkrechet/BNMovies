//
//  MovieAPIMock.swift
//  DataTests
//
//  Created by Radyslav Krechet on 28.11.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Data
import Domain

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
        var chart: Movie.Chart?
        var page: Int?
        var id: String?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    func getMovies(_ chart: Movie.Chart, page: Int, handler: @escaping Handler<[Movie]>) {
        calls.getMovies = true
        arguments.chart = chart
        arguments.page = page
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success([]))
    }

    func getMovie(with id: String, handler: @escaping Handler<Movie>) {
        calls.getMovie = true
        arguments.id = id
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(settings.movie))
    }

    func getSimilarMovies(_ id: String, handler: @escaping Handler<[Movie]>) {
        calls.getSimilarMovies = true
        arguments.id = id
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success([]))
    }
}
