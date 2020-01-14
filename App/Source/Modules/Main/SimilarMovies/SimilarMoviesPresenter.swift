//
//  SimilarMoviesPresenter.swift
//  Movies
//
//  Created by Radyslav Krechet on 9/6/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol SimilarMoviesPresenterProtocol: ListPresenterProtocol {
    var id: String! { get set }
}

class SimilarMoviesPresenter: SimilarMoviesPresenterProtocol {
    weak var view: SimilarMoviesViewProtocol?

    var id: String!

    private let getSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol

    init(getSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol) {
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
        getSimilarMoviesUseCase.execute(with: id) { [weak self] result in
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
