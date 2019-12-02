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
    // swiftlint:disable:next function_body_length
    override func spec() {
        var changeMovieFavouriteStateUseCase: ChangeMovieFavouriteStateUseCase!
        var movieRepositoryMock: MovieRepositoryMock!

        beforeEach {
            movieRepositoryMock = MovieRepositoryMock()
            changeMovieFavouriteStateUseCase = ChangeMovieFavouriteStateUseCase(movieRepository:
                movieRepositoryMock)
        }

        describe("execute") {
            context("movie is favourite") {
                let movie = self.movie(isFavourite: true)

                context("movie repository deletes from favourites -> error") {
                    it("returns error") {
                        movieRepositoryMock.settings.shouldReturnError = true

                        waitUntil { done in
                            changeMovieFavouriteStateUseCase.execute(with: movie) { result in
                                guard case .failure = result else {
                                    fail()
                                    return
                                }

                                expect(movieRepositoryMock.calls.deleteFromFavourites) == true
                                expect(movieRepositoryMock.arguments.movie).toNot(beNil())
                                done()
                            }
                        }
                    }
                }

                context("movie repository deletes from favourites -> movie") {
                    it("returns movie") {
                        waitUntil { done in
                            changeMovieFavouriteStateUseCase.execute(with: movie) { result in
                                guard case .success = result else {
                                    fail()
                                    return
                                }

                                expect(movieRepositoryMock.calls.deleteFromFavourites) == true
                                expect(movieRepositoryMock.arguments.movie).toNot(beNil())
                                done()
                            }
                        }
                    }
                }
            }

            context("movie is not favourite") {
                let movie = self.movie(isFavourite: false)

                context("movie repository adds to favourites -> error") {
                    it("returns error") {
                        movieRepositoryMock.settings.shouldReturnError = true

                        waitUntil { done in
                            changeMovieFavouriteStateUseCase.execute(with: movie) { result in
                                guard case .failure = result else {
                                    fail()
                                    return
                                }

                                expect(movieRepositoryMock.calls.addToFavourites) == true
                                expect(movieRepositoryMock.arguments.movie).toNot(beNil())
                                done()
                            }
                        }
                    }
                }

                context("movie repository adds to favourites -> movie") {
                    it("returns movie") {
                        waitUntil { done in
                            changeMovieFavouriteStateUseCase.execute(with: movie) { result in
                                guard case .success = result else {
                                    fail()
                                    return
                                }

                                expect(movieRepositoryMock.calls.addToFavourites) == true
                                expect(movieRepositoryMock.arguments.movie).toNot(beNil())
                                done()
                            }
                        }
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
                     userScore: 0,
                     isFavourite: isFavourite)
    }
}
