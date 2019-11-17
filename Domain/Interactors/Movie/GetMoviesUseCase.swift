//
//  GetMoviesUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public class GetMoviesUseCase: ParameterizableUseCase<[Movie], GetMoviesUseCase.Parameters> {
    public struct Parameters {
        let page: Int

        public init (page: Int) {
            self.page = page
        }
    }

    private let movieRepository: MovieRepositoryProtocol

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    override func work(handler: @escaping Handler<[Movie]>) {
        movieRepository.getMovies(with: parameters.page, handler: handler)
    }
}
