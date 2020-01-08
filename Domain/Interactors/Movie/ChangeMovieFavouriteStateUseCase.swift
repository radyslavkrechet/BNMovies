//
//  MarkMovieAsFavouriteUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol ChangeMovieFavouriteStateUseCaseProtocol {
    func execute(with movie: Movie, handler: @escaping Handler<Movie>)
}

public class ChangeMovieFavouriteStateUseCase: ChangeMovieFavouriteStateUseCaseProtocol, Executable {
    lazy var work = { [weak self] in
        guard let self = self else { return }

        let action = self.movie.isFavourite
            ? self.movieRepository.deleteFromFavourites
            : self.movieRepository.addToFavourites

        action(self.movie, self.handler)
    }

    @AsyncOnMain var handler: Handler<Movie>!

    private let movieRepository: MovieRepositoryProtocol
    private var movie: Movie!

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func execute(with movie: Movie, handler: @escaping Handler<Movie>) {
        self.movie = movie
        self.handler = handler
        execute()
    }
}
