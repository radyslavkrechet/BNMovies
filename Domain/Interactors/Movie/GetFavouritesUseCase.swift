//
//  GetFavouriteMoviesUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol GetFavouritesUseCaseProtocol: Executable {
    func set(_ handler: @escaping Handler<[Movie]>) -> Self
}

public class GetFavouritesUseCase: GetFavouritesUseCaseProtocol, Workable {
    private let movieRepository: MovieRepositoryProtocol
    private var handler: Handler<[Movie]>!

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func set(_ handler: @escaping Handler<[Movie]>) -> Self {
        self.handler = { result in DispatchQueue.main.async { handler(result) } }
        return self
    }

    func work() {
        movieRepository.getFavourites(handler: handler)
    }
}
