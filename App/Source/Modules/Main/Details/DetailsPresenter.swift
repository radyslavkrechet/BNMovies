//
//  DetailsPresenter.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol DetailsPresenterProtocol: ContentPresenterProtocol {
    var id: String! { get set }

    func markMovieAsFavourite()
}

class DetailsPresenter: DetailsPresenterProtocol {
    weak var view: DetailsViewProtocol?

    var id: String!

    private let getMovieUseCase: GetMovieUseCaseProtocol
    private let changeMovieFavouriteStateUseCase: ChangeMovieFavouriteStateUseCaseProtocol
    private var movie: Movie?

    init(getMovieUseCase: GetMovieUseCaseProtocol,
         changeMovieFavouriteStateUseCase: ChangeMovieFavouriteStateUseCaseProtocol) {

        self.getMovieUseCase = getMovieUseCase
        self.changeMovieFavouriteStateUseCase = changeMovieFavouriteStateUseCase
    }

    func getContent() {
        getMovie()
    }

    func tryAgain() {
        movie = nil
        getMovie()
    }

    func markMovieAsFavourite() {
        guard let movie = movie else { return }
        changeMovieFavouriteStateUseCase.execute(with: movie) { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.presentFavouriteError(error)
            case .success(let movie): self?.process(movie)
            }
        }
    }

    private func getMovie() {
        if movie == nil {
            view?.populate(with: .loading)
        }

        getMovieUseCase.execute(with: id) { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.populate(with: .error(error))
            case .success(let movie): self?.process(movie)
            }
        }
    }

    private func process(_ movie: Movie) {
        self.movie = movie
        view?.populate(with: movie)

        let favouriteTitle = movie.isFavourite
            ? "DetailsViewController.favouriteTitle.remove".localized
            : "DetailsViewController.favouriteTitle.add".localized

        view?.populate(with: favouriteTitle)
        view?.populate(with: .content)
    }
}
