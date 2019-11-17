//
//  FavouritesViewModel.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import RxSwift

class FavouritesViewModel: ListViewModelProtocol {
    private(set) lazy var state: Observable<ContentState> = stateSubject.observeOnMain()
    private(set) lazy var movies: Observable<[Movie]> = moviesSubject.observeOnMain()

    private let stateSubject = PublishSubject<ContentState>()
    private let moviesSubject = PublishSubject<[Movie]>()
    private let getFavouritesUseCase: GetFavouritesUseCase
    private var isNeedToShowLoading = true

    init(getFavouritesUseCase: GetFavouritesUseCase) {
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
            stateSubject.onNext(.loading)
        }

        getFavouritesUseCase.execute { [weak self] result in
            switch result {
            case .failure(let error): self?.stateSubject.onNext(.error(error))
            case .success(let movies): self?.process(movies)
            }
        }
    }

    private func process(_ movies: [Movie]) {
        isNeedToShowLoading = false
        moviesSubject.onNext(movies)
        stateSubject.onNext(movies.isEmpty ? .empty : .content)
    }
}
