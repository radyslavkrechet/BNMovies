//
//  MarkMovieAsFavouriteUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol ChangeMovieFavouriteStateUseCaseProtocol: Executable {
    func set(_ movie: Movie, handler: @escaping Handler<Movie>) -> Self
}

public class ChangeMovieFavouriteStateUseCase: ChangeMovieFavouriteStateUseCaseProtocol, Workable {
    private let movieRepository: MovieRepositoryProtocol
    private var movie: Movie!
    private var handler: Handler<Movie>!

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func set(_ movie: Movie, handler: @escaping Handler<Movie>) -> Self {
        self.movie = movie
        self.handler = handler
        return self
    }

    func work() {
        let action = movie.isFavourite ? movieRepository.deleteFromFavourites : movieRepository.addToFavourites
        action(movie, handler)
    }
}
