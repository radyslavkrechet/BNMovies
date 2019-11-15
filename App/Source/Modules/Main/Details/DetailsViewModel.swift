//
//  DetailsViewModel.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import RxSwift

class DetailsViewModel: ContentViewModelProtocol {
    var id: String!

    private(set) lazy var state: Observable<ContentState> = stateSubject.observeOnMain()
    private(set) lazy var movie: Observable<Movie> = movieSubject.observeOnMain()
    private(set) lazy var favouriteTitle: Observable<String> = favouriteTitleSubject.observeOnMain()
    private(set) lazy var favouriteError: Observable<Error> = favouriteErrorSubject.observeOnMain()

    private(set) lazy var favouriteDidTap: AnyObserver<Void> = AnyObserver { [weak self] event in
        if case .next = event {
            self?.markMovieAsFavourite()
        }
    }

    private let stateSubject = PublishSubject<ContentState>()
    private let movieSubject = PublishSubject<Movie>()
    private let favouriteTitleSubject = PublishSubject<String>()
    private let favouriteErrorSubject = PublishSubject<Error>()
    private let getMovieUseCase: GetMovieUseCase
    private let changeMovieFavouriteStateUseCase: ChangeMovieFavouriteStateUseCase
    private var movieValue: Movie?

    init(getMovieUseCase: GetMovieUseCase, changeMovieFavouriteStateUseCase: ChangeMovieFavouriteStateUseCase) {
        self.getMovieUseCase = getMovieUseCase
        self.changeMovieFavouriteStateUseCase = changeMovieFavouriteStateUseCase
    }

    func getContent() {
        getMovie()
    }

    func tryAgain() {
        movieValue = nil
        getMovie()
    }

    private func getMovie() {
        if movieValue == nil {
            stateSubject.onNext(.loading)
        }

        getMovieUseCase.parameters = GetMovieUseCase.Parameters(id: id)
        getMovieUseCase.execute { [weak self] result in
            switch result {
            case .failure(let error): self?.stateSubject.onNext(.error(error))
            case .success(let movie): self?.process(movie)
            }
        }
    }

    private func process(_ movie: Movie) {
        movieValue = movie
        movieSubject.onNext(movie)

        let title = movie.isFavourite
            ? "DetailsViewController.favouriteTitle.remove".localized
            : "DetailsViewController.favouriteTitle.add".localized

        favouriteTitleSubject.onNext(title)
        stateSubject.onNext(.content)
    }

    private func markMovieAsFavourite() {
        guard let movie = movieValue else { return }
        changeMovieFavouriteStateUseCase.parameters = ChangeMovieFavouriteStateUseCase.Parameters(movie: movie)
        changeMovieFavouriteStateUseCase.execute { [weak self] result in
            switch result {
            case .failure(let error): self?.favouriteErrorSubject.onNext(error)
            case .success(let movie): self?.process(movie)
            }
        }
    }
}
