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
    private var paginationService: PaginationServiceProtocol
    private var movies: [Movie]!

    init(getMoviesUseCase: GetMoviesUseCaseProtocol,
         paginationService: PaginationServiceProtocol = PaginationService()) {

        self.getMoviesUseCase = getMoviesUseCase
        self.paginationService = paginationService
    }

    func getContent() {
        getMovies()
    }

    func refreshContent() {
        paginationService.reset()
        getMovies()
    }

    func getMoreContent () {
        getMovies()
    }

    func tryAgain() {
        movies = nil
        paginationService.reset()
        getMovies()
    }

    private func getMovies() {
        guard paginationService.canGetMore else { return }
        paginationManager.startLoading()

        if movies == nil {
            view?.populate(with: .loading)
        }

        getMoviesUseCase.execute(with: paginationService.value) { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.populate(with: .error(error))
            case .success(let movies): self?.process(movies)
            }
        }
    }

    private func process(_ movies: [Movie]) {
        if paginationService.isFirstPage {
            self.movies = movies
        } else {
            self.movies += movies
        }

        view?.populate(with: self.movies)
        view?.populate(with: self.movies.isEmpty ? .empty : .content)

        paginationService.stopLoading(with: movies.count)
    }
}
