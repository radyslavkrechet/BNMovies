//
//  GetMoviesUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol GetMoviesUseCaseProtocol: Executable {
    func set(_ page: Int, handler: @escaping Handler<[Movie]>) -> Self
}

public class GetMoviesUseCase: GetMoviesUseCaseProtocol, Workable {
    private let movieRepository: MovieRepositoryProtocol
    private var page: Int!
    private var handler: Handler<[Movie]>!

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func set(_ page: Int, handler: @escaping Handler<[Movie]>) -> Self {
        self.page = page
        self.handler = { result in DispatchQueue.main.async { handler(result) } }
        return self
    }

    func work() {
        movieRepository.getMovies(with: page, handler: handler)
    }
}
