//
//  GetMoviesUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol GetMoviesUseCaseProtocol {
    func execute(with category: Movie.Category, page: Int, handler: @escaping Handler<[Movie]>)
}

public class GetMoviesUseCase: GetMoviesUseCaseProtocol, Executable {
    lazy var work = { [weak self] in
        guard let self = self else { return }
        self.movieRepository.getMovies(with: self.category, page: self.page, handler: self.handler)
    }

    @AsyncOnMain var handler: Handler<[Movie]>!

    private let movieRepository: MovieRepositoryProtocol
    private var category: Movie.Category!
    private var page: Int!

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func execute(with category: Movie.Category, page: Int, handler: @escaping Handler<[Movie]>) {
        self.category = category
        self.page = page
        self.handler = handler
        execute()
    }
}
