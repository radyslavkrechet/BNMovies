//
//  GetSimilarMoviesUseCase.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/6/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

public class GetSimilarMoviesUseCase: ParameterizableUseCase<[Movie], GetSimilarMoviesUseCase.Parameters> {
    public struct Parameters {
        let id: String

        public init(id: String) {
            self.id = id
        }
    }

    private let movieRepository: MovieRepositoryProtocol

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    override func work(handler: @escaping Handler<[Movie]>) {
        movieRepository.getSimilarMovies(parameters.id, handler: handler)
    }
}
