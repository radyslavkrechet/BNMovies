//
//  HomePresenter.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?

    private let getMoviesUseCase: GetMoviesUseCase
    private var paginationManager = PaginationManager()
    private var moviesValue: [Movie]!

    init(getMoviesUseCase: GetMoviesUseCase) {
        self.getMoviesUseCase = getMoviesUseCase
    }

    func getContent() {
        getMovies()
    }

    func refreshContent() {
        paginationManager.reset()
        getMovies()
    }

    func getMoreContent () {
        getMovies()
    }

    func tryAgain() {
        moviesValue = nil
        paginationManager.reset()
        getMovies()
    }

    private func getMovies() {
        guard paginationManager.canGetMore else { return }
        paginationManager.startLoading()

        if moviesValue == nil {
            view?.populate(with: .loading)
        }

        getMoviesUseCase.parameters = GetMoviesUseCase.Parameters(page: paginationManager.value)
        getMoviesUseCase.execute { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.populate(with: .error(error))
            case .success(let movies): self?.process(movies)
            }
        }
    }

    private func process(_ movies: [Movie]) {
        if paginationManager.isFirstPage {
            moviesValue = movies
        } else {
            moviesValue += movies
        }

        view?.populate(with: movies)
        view?.populate(with: moviesValue.isEmpty ? .empty : .content)

        paginationManager.stopLoading(with: movies.count)
    }
}
