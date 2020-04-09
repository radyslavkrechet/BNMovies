//
//  HomePresenter.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Core
import Domain

protocol HomePresenterProtocol: PaginationPresenterProtocol {
    func changeChart(_ chart: Movie.Chart)
}

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?

    private let getMoviesUseCase: GetChartUseCaseProtocol
    private var paginationService: PaginationServiceProtocol
    private var chart = Movie.Chart.popular
    private var movies: [Movie]!

    init(getMoviesUseCase: GetChartUseCaseProtocol,
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

    func changeChart(_ chart: Movie.Chart) {
        self.chart = chart
        tryAgain()
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
