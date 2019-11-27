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
    lazy var work = {
        self.movieRepository.getFavourites(handler: self.handler)
    }

    private let movieRepository: MovieRepositoryProtocol
    private var handler: Handler<[Movie]>!

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func execute(_ handler: @escaping Handler<[Movie]>) {
        self.handler = { result in DispatchQueue.main.async { handler(result) } }
        execute()
    }
}
