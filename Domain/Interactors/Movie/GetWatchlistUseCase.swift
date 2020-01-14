//
//  GetWatchlistUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 13.01.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol GetWatchlistUseCaseProtocol {
    func execute(_ handler: @escaping Handler<[Movie]>)
}

public class GetWatchlistUseCase: GetWatchlistUseCaseProtocol, Executable {
    lazy var work = { [weak self] in
        guard let self = self else { return }
        self.movieRepository.getWatchlist(handler: self.handler)
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
