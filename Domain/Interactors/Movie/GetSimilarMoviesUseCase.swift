//
//  GetSimilarMoviesUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 9/6/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol GetSimilarMoviesUseCaseProtocol: Executable {
    func set(_ id: String, handler: @escaping Handler<[Movie]>) -> Self
}

public class GetSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol, Workable {
    private let movieRepository: MovieRepositoryProtocol
    private var id: String!
    private var handler: Handler<[Movie]>!

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func set(_ id: String, handler: @escaping Handler<[Movie]>) -> Self {
        self.id = id
        return self
    }

    func work() {
        movieRepository.getSimilarMovies(id, handler: handler)
    }
}
