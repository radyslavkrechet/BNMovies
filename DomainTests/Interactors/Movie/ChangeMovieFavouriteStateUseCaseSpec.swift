//
//  ChangeMovieFavouriteStateUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 27.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class ChangeMovieFavouriteStateUseCaseSpec: QuickSpec {
    override func spec() {
        describe("execute") {
            movieIsFavourite()
            movieIsNotFavourite()
        }
    }

    private func movieIsFavourite() {
        context("movie repository returns error") {
            it("returns error") {
                let movie = self.movie(isFavourite: true)
                let movieRepository = MovieRepositoryMock(settings: .failure)
                let changeMovieFavouriteStateUseCase = ChangeMovieFavouriteStateUseCase(movieRepository:
                    movieRepository)

                changeMovieFavouriteStateUseCase.execute(with: movie) { result in
                    switch result {
                    case .failure: pass()
                    case .success: fail()
                    }
                }
            }
        }

        context("movie repository returns movie") {
            it("returns movie") {
                let movie = self.movie(isFavourite: true)
                let movieRepository = MovieRepositoryMock(settings: .success(isTruthy: true))
                let changeMovieFavouriteStateUseCase = ChangeMovieFavouriteStateUseCase(movieRepository:
                    movieRepository)

                changeMovieFavouriteStateUseCase.execute(with: movie) { result in
                    switch result {
                    case .failure: fail()
                    case .success: expect(movieRepository.deletedFromFavourites).toNot(beNil())
                    }
                }
            }
        }
    }

    private func movieIsNotFavourite() {
        context("movie repository returns error") {
            it("returns error") {
                let movie = self.movie(isFavourite: false)
                let movieRepository = MovieRepositoryMock(settings: .failure)
                let changeMovieFavouriteStateUseCase = ChangeMovieFavouriteStateUseCase(movieRepository:
                    movieRepository)

                changeMovieFavouriteStateUseCase.execute(with: movie) { result in
                    switch result {
                    case .failure: pass()
                    case .success: fail()
                    }
                }
            }
        }

        context("movie repository returns movie") {
            it("returns movie") {
                let movie = self.movie(isFavourite: false)
                let movieRepository = MovieRepositoryMock(settings: .success(isTruthy: true))
                let changeMovieFavouriteStateUseCase = ChangeMovieFavouriteStateUseCase(movieRepository:
                    movieRepository)

                changeMovieFavouriteStateUseCase.execute(with: movie) { result in
                    switch result {
                    case .failure: fail()
                    case .success: expect(movieRepository.addedToFavourites).toNot(beNil())
                    }
                }
            }
        }
    }

    private func movie(isFavourite: Bool) -> Movie {
        return Movie(id: "id",
                     title: "title",
                     overview: "overview",
                     posterSource: "posterSource",
                     backdropSource: "backdropSource",
                     runtime: 0,
                     releaseDate: Date(),
                     userScore: 0,
                     genres: [Genre(id: "id", name: "name")],
                     isFavourite: isFavourite)
    }
}
