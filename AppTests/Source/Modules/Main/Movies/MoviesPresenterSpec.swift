//
//  MoviesPresenterSpec.swift
//  BoilerplateTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain

@testable import Boilerplate

class MoviesPresenterSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var moviesPresenter: MoviesPresenter!
        var getFavouritesUseCaseMock: GetFavouritesUseCaseMock!
        var getWatchlistUseCaseMock: GetWatchlistUseCaseMock!
        var moviesViewMock: MoviesViewMock!

        beforeEach {
            getFavouritesUseCaseMock = GetFavouritesUseCaseMock()
            getWatchlistUseCaseMock = GetWatchlistUseCaseMock()
            moviesPresenter = MoviesPresenter(getFavouritesUseCase: getFavouritesUseCaseMock,
                                              getWatchlistUseCase: getWatchlistUseCaseMock)

            moviesViewMock = MoviesViewMock()
            moviesPresenter.view = moviesViewMock
        }

        describe("get content") {
            beforeEach {
                moviesPresenter.source = .favourites
            }

            context("first time") {
                context("get favourites use case executes -> error") {
                    it("populates view with loading state, populates view with error state") {
                        getFavouritesUseCaseMock.settings.shouldReturnError = true

                        moviesPresenter.getContent()

                        expect(getFavouritesUseCaseMock.calls.execute) == true
                        expect(moviesViewMock.calls.populateWithState) == true
                        expect(moviesViewMock.arguments.states) == [.loading, .error(Mock.Error.force)]
                    }
                }

                context("get favourites use case executes -> empty array") {
                    it("populates view with loading state, populates view with empty state and movies") {
                        getFavouritesUseCaseMock.settings.shouldReturnEmpty = true

                        moviesPresenter.getContent()

                        expect(getFavouritesUseCaseMock.calls.execute) == true
                        expect(moviesViewMock.calls.populateWithState) == true
                        expect(moviesViewMock.arguments.states) == [.loading, .empty]
                        expect(moviesViewMock.calls.populateWithMovies) == true
                    }
                }

                context("get favourites use case executes -> movies") {
                    it("populates view with loading state, populates view with content state and movies") {
                        moviesPresenter.getContent()

                        expect(getFavouritesUseCaseMock.calls.execute) == true
                        expect(moviesViewMock.calls.populateWithState) == true
                        expect(moviesViewMock.arguments.states) == [.loading, .content]
                        expect(moviesViewMock.calls.populateWithMovies) == true
                    }
                }
            }

            context("not first time") {
                context("get favourites use case executes -> movies") {
                    it("populates view with content state and movies") {
                        moviesPresenter.getContent()
                        moviesPresenter.getContent()

                        expect(getFavouritesUseCaseMock.calls.execute) == true
                        expect(moviesViewMock.calls.populateWithState) == true
                        expect(moviesViewMock.arguments.states) == [.loading, .content, .content]
                        expect(moviesViewMock.calls.populateWithMovies) == true
                    }
                }
            }
        }

        describe("try again") {
            beforeEach {
                moviesPresenter.source = .watchlist
            }

            context("first time") {
                context("get watchlist use case executes -> error") {
                    it("populates view with loading state, populates view with error state") {
                        getWatchlistUseCaseMock.settings.shouldReturnError = true

                        moviesPresenter.tryAgain()

                        expect(getWatchlistUseCaseMock.calls.execute) == true
                        expect(moviesViewMock.calls.populateWithState) == true
                        expect(moviesViewMock.arguments.states) == [.loading, .error(Mock.Error.force)]
                    }
                }

                context("get watchlist use case executes -> empty array") {
                    it("populates view with loading state, populates view with empty state and movies") {
                        getWatchlistUseCaseMock.settings.shouldReturnEmpty = true

                        moviesPresenter.tryAgain()

                        expect(getWatchlistUseCaseMock.calls.execute) == true
                        expect(moviesViewMock.calls.populateWithState) == true
                        expect(moviesViewMock.arguments.states) == [.loading, .empty]
                        expect(moviesViewMock.calls.populateWithMovies) == true
                    }
                }

                context("get watchlist use case executes -> movies") {
                    it("populates view with loading state, populates view with content state and movies") {
                        moviesPresenter.tryAgain()

                        expect(getWatchlistUseCaseMock.calls.execute) == true
                        expect(moviesViewMock.calls.populateWithState) == true
                        expect(moviesViewMock.arguments.states) == [.loading, .content]
                        expect(moviesViewMock.calls.populateWithMovies) == true
                    }
                }
            }

            context("not first time") {
                context("get watchlist use case executes -> movies") {
                    it("populates view with loading state, populates view with content state and movies") {
                        moviesPresenter.getContent()
                        moviesPresenter.tryAgain()

                        expect(getWatchlistUseCaseMock.calls.execute) == true
                        expect(moviesViewMock.calls.populateWithState) == true
                        expect(moviesViewMock.arguments.states) == [.loading, .content, .loading, .content]
                        expect(moviesViewMock.calls.populateWithMovies) == true
                    }
                }
            }
        }
    }
}
