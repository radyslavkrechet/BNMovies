//
//  GetSimilarMoviesUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 9/6/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol GetSimilarMoviesUseCaseProtocol {
    func execute(with id: String, handler: @escaping Handler<[Movie]>)
}

public class GetSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol, Executable {
    lazy var work = { [weak self] in
        guard let self = self else { return }
        self.movieRepository.getSimilarMovies(self.id, handler: self.handler)
    }

    @AsyncOnMain var handler: Handler<[Movie]>!

    private let movieRepository: MovieRepositoryProtocol
    private var id: String!

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func execute(with id: String, handler: @escaping Handler<[Movie]>) {
        self.id = id
        self.handler = handler
        execute()
    }
}
