//
//  SimilarMoviesViewModel.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/6/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import RxSwift

class SimilarMoviesViewModel: ListViewModelProtocol {
    var id: String!

    private(set) lazy var state: Observable<ContentState> = stateSubject.observeOnMain()
    private(set) lazy var movies: Observable<[Movie]> = moviesSubject.observeOnMain()

    private let stateSubject = PublishSubject<ContentState>()
    private let moviesSubject = PublishSubject<[Movie]>()
    private let getSimilarMoviesUseCase: GetSimilarMoviesUseCase

    init(getSimilarMoviesUseCase: GetSimilarMoviesUseCase) {
        self.getSimilarMoviesUseCase = getSimilarMoviesUseCase
    }

    func getContent() {
        getMovies()
    }

    func tryAgain() {
        getMovies()
    }

    private func getMovies() {
        stateSubject.onNext(.loading)
        getSimilarMoviesUseCase.parameters = GetSimilarMoviesUseCase.Parameters(id: id)
        getSimilarMoviesUseCase.execute { [weak self] result in
            switch result {
            case .failure(let error): self?.stateSubject.onNext(.error(error))
            case .success(let movies): self?.process(movies)
            }
        }
    }

    private func process(_ movies: [Movie]) {
        moviesSubject.onNext(movies)
        stateSubject.onNext(movies.isEmpty ? .empty : .content)
    }
}
