//
//  FavouritesPresenter.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol FavouritesPresenterProtocol: ListPresenterProtocol {}

class FavouritesPresenter: FavouritesPresenterProtocol {
    weak var view: FavouritesViewProtocol?

    private let getFavouritesUseCase: GetFavouritesUseCaseProtocol
    private var isNeedToShowLoading = true

    init(getFavouritesUseCase: GetFavouritesUseCaseProtocol) {
        self.getFavouritesUseCase = getFavouritesUseCase
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

        getFavouritesUseCase.set { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.populate(with: .error(error))
            case .success(let movies): self?.process(movies)
            }
        }.execute()
    }

    private func process(_ movies: [Movie]) {
        isNeedToShowLoading = false
        view?.populate(with: movies)
        view?.populate(with: movies.isEmpty ? .empty : .content)
    }
}
