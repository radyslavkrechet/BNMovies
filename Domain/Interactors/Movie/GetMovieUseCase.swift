//
//  GetMovieUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol GetMovieUseCaseProtocol {
    func execute(with id: String, handler: @escaping Handler<Movie>)
}

public class GetMovieUseCase: GetMovieUseCaseProtocol, Executable {
    lazy var work = { [weak self] in
        guard let self = self else { return }
        self.movieRepository.getMovie(with: self.id, handler: self.handler)
    }

    private let movieRepository: MovieRepositoryProtocol
    private var id: String!
    private var handler: Handler<Movie>!

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func execute(with id: String, handler: @escaping Handler<Movie>) {
        self.id = id
        self.handler = { result in DispatchQueue.main.async { handler(result) } }
        execute()
    }
}
