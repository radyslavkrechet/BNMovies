//
//  MarkMovieAsFavouriteUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public class ChangeMovieFavouriteStateUseCase: ParameterizableUseCase<Movie,
    ChangeMovieFavouriteStateUseCase.Parameters> {

    public struct Parameters {
        let movie: Movie

        public init(movie: Movie) {
            self.movie = movie
        }
    }

    private let movieRepository: MovieRepositoryProtocol

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    override func work(handler: @escaping Handler<Movie>) {
        let action = parameters.movie.isFavourite
            ? movieRepository.deleteFromFavourites
            : movieRepository.addToFavourites

        action(parameters.movie, handler)
    }
}
