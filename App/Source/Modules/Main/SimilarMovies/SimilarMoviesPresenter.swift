//
//  SimilarMoviesPresenter.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/6/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

class SimilarMoviesPresenter: SimilarMoviesPresenterProtocol {
    weak var view: SimilarMoviesViewProtocol?

    var id: String!

    private let getSimilarMoviesUseCase: GetSimilarMoviesUseCase

    init(getSimilarMoviesUseCase: GetSimilarMoviesUseCase) {
        self.getSimilarMoviesUseCase = getSimilarMoviesUseCase
    }

    func getContent() {
        getMovies()
    }

    func tryAgain() {
        getMovies()
    }

    private func getMovies() {
        view?.populate(with: .loading)
        getSimilarMoviesUseCase.parameters = GetSimilarMoviesUseCase.Parameters(id: id)
        getSimilarMoviesUseCase.execute { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.populate(with: .error(error))
            case .success(let movies): self?.process(movies)
            }
        }
    }

    private func process(_ movies: [Movie]) {
        view?.populate(with: movies)
        view?.populate(with: movies.isEmpty ? .empty : .content)
    }
}
