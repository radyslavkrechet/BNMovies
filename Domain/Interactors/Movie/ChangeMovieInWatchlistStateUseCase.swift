//
//  ChangeMovieInWatchlistStateUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 13.01.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol ChangeMovieInWatchlistStateUseCaseProtocol {
    func execute(with movie: Movie, handler: @escaping Handler<Movie>)
}

public class ChangeMovieInWatchlistStateUseCase: ChangeMovieInWatchlistStateUseCaseProtocol, Executable {
    lazy var work = { [weak self] in
        guard let self = self else { return }

        let action = self.movie.isInWatchlist
            ? self.movieRepository.deleteFromWatchlist
            : self.movieRepository.addToWatchlist

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
