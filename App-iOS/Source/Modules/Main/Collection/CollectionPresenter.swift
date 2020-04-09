//
//  CollectionPresenter.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Core
import Domain

protocol CollectionPresenterProtocol: ListPresenterProtocol {
    var collection: Movie.Collection! { get set }
}

class CollectionPresenter: CollectionPresenterProtocol {
    weak var view: CollectionViewProtocol?

    var collection: Movie.Collection!

    private let getCollectionUseCase: GetCollectionUseCaseProtocol
    private var isNeedToShowLoading = true

    init(getCollectionUseCase: GetCollectionUseCaseProtocol) {
        self.getCollectionUseCase = getCollectionUseCase
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

        getCollectionUseCase.execute(with: collection) { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.populate(with: .error(error))
            case .success(let movies): self?.process(movies)
            }
        }
    }

    private func process(_ movies: [Movie]) {
        isNeedToShowLoading = false
        view?.populate(with: movies)
        view?.populate(with: movies.isEmpty ? .empty : .content)
    }
}
