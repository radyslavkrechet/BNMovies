//
//  DetailsPresenter.swift
//  Movies
//
//  Created by Radyslav Krechet on 10.04.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Core
import Domain

protocol DetailsPresenterProtocol: ContentPresenterProtocol {
    var id: String! { get set }
}

class DetailsPresenter: DetailsPresenterProtocol {
    weak var view: DetailsViewProtocol?

    var id: String!

    private let getMovieUseCase: GetMovieUseCaseProtocol

    init(getMovieUseCase: GetMovieUseCaseProtocol) {

        self.getMovieUseCase = getMovieUseCase
    }

    func getContent() {
        getMovie()
    }

    func tryAgain() {
        getMovie()
    }

    private func getMovie() {
        view?.populate(with: .loading)

        getMovieUseCase.execute(with: id) { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.populate(with: .error(error))
            case .success(let movie): self?.process(movie)
            }
        }
    }

    private func process(_ movie: Movie) {
        view?.populate(with: movie)
        view?.populate(with: .content)
    }
}
