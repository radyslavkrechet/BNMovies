//
//  GetMoviesUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol GetMoviesUseCaseProtocol {
    func execute(with page: Int, handler: @escaping Handler<[Movie]>)
}

public class GetMoviesUseCase: GetMoviesUseCaseProtocol, Executable {
    lazy var work = {
        self.movieRepository.getMovies(with: self.page, handler: self.handler)
    }

    private let movieRepository: MovieRepositoryProtocol
    private var page: Int!
    private var handler: Handler<[Movie]>!

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func execute(with page: Int, handler: @escaping Handler<[Movie]>) {
        self.page = page
        self.handler = { result in DispatchQueue.main.async { handler(result) } }
        execute()
    }
}
