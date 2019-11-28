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
        describe("execute") {
            var changeMovieFavouriteStateUseCase: ChangeMovieFavouriteStateUseCase!
            var movieRepositoryMock: MovieRepositoryMock!

            beforeEach {
                movieRepositoryMock = MovieRepositoryMock()
                changeMovieFavouriteStateUseCase = ChangeMovieFavouriteStateUseCase(movieRepository:
                    movieRepositoryMock)
            }

            context("movie is favourite, movie repository returns error") {
                it("returns error") {
                    let movie = self.movie(isFavourite: true)
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

            context("movie is favourite, movie repository returns movie") {
                it("returns movie") {
                    let movie = self.movie(isFavourite: true)

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

            context("movie is not favourite, movie repository returns error") {
                it("returns error") {
                    let movie = self.movie(isFavourite: false)
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

            context("movie is not favourite, movie repository returns movie") {
                it("returns movie") {
                    let movie = self.movie(isFavourite: false)

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
