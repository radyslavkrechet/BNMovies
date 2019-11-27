//
//  MovieRepositoryMock.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 26.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

class MovieRepositoryMock: MovieRepositoryProtocol {
    var settings: MockSettings
    var addedToFavourites: Movie?
    var deletedFromFavourites: Movie?

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

    init(settings: MockSettings) {
        self.settings = settings
    }

    func getMovies(with page: Int, handler: @escaping Handler<[Movie]>) {
        switch settings {
        case .failure: handler(.failure(MockError.force))
        case .success: handler(.success([movieMock]))
        }
    }

    func getFavourites(handler: @escaping Handler<[Movie]>) {
        switch settings {
        case .failure: handler(.failure(MockError.force))
        case .success: handler(.success([movieMock]))
        }
    }

    func getMovie(with id: String, handler: @escaping Handler<Movie>) {
        switch settings {
        case .failure: handler(.failure(MockError.force))
        case .success: handler(.success(movieMock))
        }
    }

    func getSimilarMovies(_ id: String, handler: @escaping Handler<[Movie]>) {
        switch settings {
        case .failure: handler(.failure(MockError.force))
        case .success: handler(.success([movieMock]))
        }
    }

    func addToFavourites(_ movie: Movie, handler: @escaping Handler<Movie>) {
        addedToFavourites = movie

        switch settings {
        case .failure: handler(.failure(MockError.force))
        case .success: handler(.success(movieMock))
        }
    }

    func deleteFromFavourites(_ movie: Movie, handler: @escaping Handler<Movie>) {
        deletedFromFavourites = movie

        switch settings {
        case .failure: handler(.failure(MockError.force))
        case .success: handler(.success(movieMock))
        }
    }
}
