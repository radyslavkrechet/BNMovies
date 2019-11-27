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
    lazy var work = {
        self.movieRepository.getSimilarMovies(self.id, handler: self.handler)
    }

    private let movieRepository: MovieRepositoryProtocol
    private var id: String!
    private var handler: Handler<[Movie]>!

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func execute(with id: String, handler: @escaping Handler<[Movie]>) {
        self.id = id
        self.handler = { result in DispatchQueue.main.async { handler(result) } }
        execute()
    }
}
