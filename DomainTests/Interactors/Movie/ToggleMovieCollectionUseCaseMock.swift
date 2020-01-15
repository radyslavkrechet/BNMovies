//
//  ToggleMovieCollectionUseCaseMock.swift
//  MoviesTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

@testable import Domain

class ToggleMovieCollectionUseCaseMock: ToggleMovieCollectionUseCaseProtocol {
    struct Settings {
        var shouldReturnError = false
    }

    struct Calls {
        var execute = false
    }

    struct Arguments {
        var movie: Movie?
        var collection: Movie.Collection?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    func execute(with movie: Movie, collection: Movie.Collection, handler: @escaping Handler<Movie>) {
        calls.execute = true
        arguments.movie = movie
        arguments.collection = collection
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.movie))
    }
}
