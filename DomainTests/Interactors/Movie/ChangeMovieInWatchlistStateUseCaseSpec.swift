//
//  ChangeMovieInWatchlistStateUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 14.01.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class ChangeMovieInWatchlistStateUseCaseSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var changeMovieInWatchlistStateUseCase: ChangeMovieInWatchlistStateUseCase!
        var movieRepositoryMock: MovieRepositoryMock!

        beforeEach {
            movieRepositoryMock = MovieRepositoryMock()
            changeMovieInWatchlistStateUseCase = ChangeMovieInWatchlistStateUseCase(movieRepository:
                movieRepositoryMock)
        }

        describe("execute") {
            context("movie is in watchlist") {
                let movie = Mock.movie(isFavourite: false, isInWatchlist: true)

                context("movie repository deletes from watchlist -> error") {
                    it("returns error") {
                        movieRepositoryMock.settings.shouldReturnError = true

                        waitUntil { done in
                            changeMovieInWatchlistStateUseCase.execute(with: movie) { result in
                                guard case .failure = result else {
                                    fail()
                                    return
                                }

                                expect(movieRepositoryMock.calls.deleteFromWatchlist) == true
                                expect(movieRepositoryMock.arguments.movie) == movie
                                done()
                            }
                        }
                    }
                }

                context("movie repository deletes from watchlist -> movie") {
                    it("returns movie") {
                        waitUntil { done in
                            changeMovieInWatchlistStateUseCase.execute(with: movie) { result in
                                guard case .success = result else {
                                    fail()
                                    return
                                }

                                expect(movieRepositoryMock.calls.deleteFromWatchlist) == true
                                expect(movieRepositoryMock.arguments.movie) == movie
                                done()
                            }
                        }
                    }
                }
            }

            context("movie is not in watchlist") {
                let movie = Mock.movie(isFavourite: false, isInWatchlist: false)

                context("movie repository adds to watchlist -> error") {
                    it("returns error") {
                        movieRepositoryMock.settings.shouldReturnError = true

                        waitUntil { done in
                            changeMovieInWatchlistStateUseCase.execute(with: movie) { result in
                                guard case .failure = result else {
                                    fail()
                                    return
                                }

                                expect(movieRepositoryMock.calls.addToWatchlist) == true
                                expect(movieRepositoryMock.arguments.movie) == movie
                                done()
                            }
                        }
                    }
                }

                context("movie repository adds to watchlist -> movie") {
                    it("returns movie") {
                        waitUntil { done in
                            changeMovieInWatchlistStateUseCase.execute(with: movie) { result in
                                guard case .success = result else {
                                    fail()
                                    return
                                }

                                expect(movieRepositoryMock.calls.addToWatchlist) == true
                                expect(movieRepositoryMock.arguments.movie) == movie
                                done()
                            }
                        }
                    }
                }
            }
        }
    }
}
