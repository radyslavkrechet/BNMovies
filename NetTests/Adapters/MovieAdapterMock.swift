//
//  MovieAdapterMock.swift
//  NetTests
//
//  Created by Radyslav Krechet on 02.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Net

private enum Mock {
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

class MovieAdapterMock: MovieAdapterProtocol {
    struct Calls {
        var toEntities = false
        var toEntity = false
    }

    var calls = Calls()

    func toEntities(_ response: GetMoviesResponse) -> [Movie] {
        calls.toEntities = true
        return Mock.movies
    }

    func toEntity(_ response: GetMovieResponse) -> Movie {
        calls.toEntity = true
        return Mock.movie
    }
}
