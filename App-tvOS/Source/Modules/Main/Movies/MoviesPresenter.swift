//
//  MoviesPresenter.swift
//  Movies
//
//  Created by Radyslav Krechet on 10.04.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Core
import Domain

protocol MoviesPresenterProtocol: PaginationPresenterProtocol {
    var chart: Movie.Chart! { get set }
}

class MoviesPresenter: MoviesPresenterProtocol {
    weak var view: MoviesViewProtocol?

    var chart: Movie.Chart!

    private let getMoviesUseCase: GetChartUseCaseProtocol
    private var paginationService: PaginationServiceProtocol
    private var movies: [Movie]!

    init(getMoviesUseCase: GetChartUseCaseProtocol,
         paginationService: PaginationServiceProtocol = PaginationService()) {

        self.getMoviesUseCase = getMoviesUseCase
        self.paginationService = paginationService
    }

    func getContent() {
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
        paginationService.startLoading()

        if movies == nil {
            view?.populate(with: .loading)
        }

        getMoviesUseCase.execute(with: chart, page: paginationService.page) { [weak self] result in
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
