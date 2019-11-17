//
//  HomeViewModel.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import RxSwift

class HomeViewModel: PaginationViewModelProtocol {
    private(set) lazy var state: Observable<ContentState> = stateSubject.observeOnMain()
    private(set) lazy var movies: Observable<[Movie]> = moviesSubject.observeOnMain()

    private(set) lazy var refreshControlDidPull: AnyObserver<Void> = AnyObserver { [weak self] event in
        if case .next = event {
            self?.refreshMovies()
        }
    }

    private let stateSubject = PublishSubject<ContentState>()
    private let moviesSubject = PublishSubject<[Movie]>()
    private let getMoviesUseCase: GetMoviesUseCase
    private var paginationManager = PaginationManager()
    private var moviesValue: [Movie]!

    init(getMoviesUseCase: GetMoviesUseCase) {
        self.getMoviesUseCase = getMoviesUseCase
    }

    func getContent() {
        getMovies()
    }

    func getMoreContent () {
        getMovies()
    }

    func tryAgain() {
        moviesValue = nil
        refreshMovies()
    }

    private func getMovies() {
        guard paginationManager.canGetMore else { return }
        paginationManager.startLoading()

        if moviesValue == nil {
            stateSubject.onNext(.loading)
        }

        getMoviesUseCase.parameters = GetMoviesUseCase.Parameters(page: paginationManager.value)
        getMoviesUseCase.execute { [weak self] result in
            switch result {
            case .failure(let error): self?.stateSubject.onNext(.error(error))
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

        moviesSubject.onNext(moviesValue)
        stateSubject.onNext(moviesValue.isEmpty ? .empty : .content)

        paginationManager.stopLoading(with: movies.count)
    }

    private func refreshMovies() {
        paginationManager.reset()
        getMovies()
    }
}
