//
//  DetailsPresenter.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

private let baseURL = "https://www.themoviedb.org/movie/"

protocol DetailsPresenterProtocol: ContentPresenterProtocol {
    var id: String! { get set }
    var shareURL: String { get }

    func markMovie(_ collection: Movie.Collection)
}

class DetailsPresenter: DetailsPresenterProtocol {
    weak var view: DetailsViewProtocol?

    var id: String!

    var shareURL: String {
        return "\(baseURL)\(id!)"
    }

    private let getMovieUseCase: GetMovieUseCaseProtocol
    private let toggleMovieCollectionUseCase: ToggleMovieCollectionUseCaseProtocol
    private var movie: Movie?

    init(getMovieUseCase: GetMovieUseCaseProtocol,
         toggleMovieCollectionUseCase: ToggleMovieCollectionUseCaseProtocol) {

        self.getMovieUseCase = getMovieUseCase
        self.toggleMovieCollectionUseCase = toggleMovieCollectionUseCase
    }

    func getContent() {
        getMovie()
    }

    func tryAgain() {
        movie = nil
        getMovie()
    }

    func markMovie(_ collection: Movie.Collection) {
        guard let movie = movie else { return }

        toggleMovieCollectionUseCase.execute(with: movie, collection: collection) { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.presentMarkError(error)
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
        view?.populate(with: .content)
    }
}
