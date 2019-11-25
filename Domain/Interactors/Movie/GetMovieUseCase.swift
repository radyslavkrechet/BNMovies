//
//  GetMovieUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol GetMovieUseCaseProtocol: Executable {
    func set(_ id: String, handler: @escaping Handler<Movie>) -> Self
}

public class GetMovieUseCase: GetMovieUseCaseProtocol, Workable {
    private let movieRepository: MovieRepositoryProtocol
    private var id: String!
    private var handler: Handler<Movie>!

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func set(_ id: String, handler: @escaping Handler<Movie>) -> Self {
        self.id = id
        self.handler = handler
        return self
    }

    func work() {
        movieRepository.getMovie(with: id, handler: handler)
    }
}
