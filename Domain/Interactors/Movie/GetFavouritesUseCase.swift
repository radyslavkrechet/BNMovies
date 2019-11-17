//
//  GetFavouriteMoviesUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public class GetFavouritesUseCase: UseCase<[Movie]> {
    private let movieRepository: MovieRepositoryProtocol

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    override func work(handler: @escaping Handler<[Movie]>) {
        movieRepository.getFavourites(handler: handler)
    }
}
