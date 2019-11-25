//
//  HomePresenter.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol HomePresenterProtocol: PaginationPresenterProtocol {}

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?

    private let getMoviesUseCase: GetMoviesUseCaseProtocol
    private var paginationManager: PaginationManagerProtocol
    private var movies: [Movie]!

    init(getMoviesUseCase: GetMoviesUseCaseProtocol,
         paginationManager: PaginationManagerProtocol = PaginationManager()) {

        self.getMoviesUseCase = getMoviesUseCase
        self.paginationManager = paginationManager
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
        movies = nil
        paginationManager.reset()
        getMovies()
    }

    private func getMovies() {
        guard paginationManager.canGetMore else { return }
        paginationManager.startLoading()

        if movies == nil {
            view?.populate(with: .loading)
        }

        getMoviesUseCase.set(paginationManager.value) { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.populate(with: .error(error))
            case .success(let movies): self?.process(movies)
            }
        }.execute()
    }

    private func process(_ movies: [Movie]) {
        if paginationManager.isFirstPage {
            self.movies = movies
        } else {
            self.movies += movies
        }

        view?.populate(with: self.movies)
        view?.populate(with: self.movies.isEmpty ? .empty : .content)

        paginationManager.stopLoading(with: movies.count)
    }
}
