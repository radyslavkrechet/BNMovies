//
//  GetFavouriteMoviesUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol GetFavouritesUseCaseProtocol {
    func execute(_ handler: @escaping Handler<[Movie]>)
}

public class GetFavouritesUseCase: GetFavouritesUseCaseProtocol, Executable {
    lazy var work = { [weak self] in
        guard let self = self else { return }
        self.movieRepository.getFavourites(handler: self.handler)
    }

    @AsyncOnMain var handler: Handler<[Movie]>!

    private let movieRepository: MovieRepositoryProtocol

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func execute(_ handler: @escaping Handler<[Movie]>) {
        self.handler = handler
        execute()
    }
}
