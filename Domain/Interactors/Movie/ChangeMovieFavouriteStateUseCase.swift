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
    lazy var work = {
        let action = self.movie.isFavourite
            ? self.movieRepository.deleteFromFavourites
            : self.movieRepository.addToFavourites

        action(self.movie, self.handler)
    }

    private let movieRepository: MovieRepositoryProtocol
    private var movie: Movie!
    private var handler: Handler<Movie>!

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func execute(with movie: Movie, handler: @escaping Handler<Movie>) {
        self.movie = movie
        self.handler = { result in DispatchQueue.main.async { handler(result) } }
        execute()
    }
}
