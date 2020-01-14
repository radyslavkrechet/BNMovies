//
//  MoviesPresenter.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol MoviesPresenterProtocol: ListPresenterProtocol {}

class MoviesPresenter: MoviesPresenterProtocol {
    weak var view: MoviesViewProtocol?

    var source: Movie.List!

    private let getFavouritesUseCase: GetFavouritesUseCaseProtocol
    private let getWatchlistUseCase: GetWatchlistUseCaseProtocol
    private var isNeedToShowLoading = true

    init(getFavouritesUseCase: GetFavouritesUseCaseProtocol, getWatchlistUseCase: GetWatchlistUseCaseProtocol) {
        self.getFavouritesUseCase = getFavouritesUseCase
        self.getWatchlistUseCase = getWatchlistUseCase
    }

    func getContent() {
        getMovies()
    }

    func tryAgain() {
        isNeedToShowLoading = true
        getMovies()
    }

    private func getMovies() {
        if isNeedToShowLoading {
            view?.populate(with: .loading)
        }

        let handler: Handler<[Movie]> = { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.populate(with: .error(error))
            case .success(let movies): self?.process(movies)
            }
        }

        let action = source == .favourites ? getFavouritesUseCase.execute : getWatchlistUseCase.execute
        action(handler)
    }

    private func process(_ movies: [Movie]) {
        isNeedToShowLoading = false
        view?.populate(with: movies)
        view?.populate(with: movies.isEmpty ? .empty : .content)
    }
}
