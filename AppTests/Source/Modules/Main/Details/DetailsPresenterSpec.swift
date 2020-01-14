//
//  DetailsPresenterSpec.swift
//  Movies
//
//  Created by Radyslav Krechet on 10.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Movies

class DetailsPresenterSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        let id = "id"

        var detailsPresenter: DetailsPresenter!
        var getMovieUseCaseMock: GetMovieUseCaseMock!
        var changeMovieFavouriteStateUseCaseMock: ChangeMovieFavouriteStateUseCaseMock!
        var changeMovieInWatchlistStateUseCaseMock: ChangeMovieInWatchlistStateUseCaseMock!
        var detailsViewMock: DetailsViewMock!

        beforeEach {
            getMovieUseCaseMock = GetMovieUseCaseMock()
            changeMovieFavouriteStateUseCaseMock = ChangeMovieFavouriteStateUseCaseMock()
            changeMovieInWatchlistStateUseCaseMock = ChangeMovieInWatchlistStateUseCaseMock()
            detailsPresenter = DetailsPresenter(getMovieUseCase: getMovieUseCaseMock,
                                                changeMovieFavouriteStateUseCase: changeMovieFavouriteStateUseCaseMock,
                                                changeMovieInWatchlistStateUseCase:
                                                    changeMovieInWatchlistStateUseCaseMock)

            detailsViewMock = DetailsViewMock()
            detailsPresenter.view = detailsViewMock
            detailsPresenter.id = id
        }

        describe("share url") {
            it("returns correct value") {
                expect(detailsPresenter.shareURL) == "https://www.themoviedb.org/movie/\(id)"
            }
        }

        describe("get content") {
            context("first time") {
                context("get movie use case executes -> error") {
                    it("populates view with loading state, populates view with error state") {
                        getMovieUseCaseMock.settings.shouldReturnError = true

                        detailsPresenter.getContent()

                        expect(getMovieUseCaseMock.calls.execute) == true
                        expect(getMovieUseCaseMock.arguments.id) == id

                        expect(detailsViewMock.calls.populateWithState) == true
                        expect(detailsViewMock.arguments.states) == [.loading, .error(Mock.Error.force)]
                    }
                }

                context("get movie use case executes -> movie") {
                    context("movie is not favourite") {
                        it("populates view with loading state, populates view with content state, movie and title") {
                            detailsPresenter.getContent()

                            expect(getMovieUseCaseMock.calls.execute) == true
                            expect(getMovieUseCaseMock.arguments.id) == id

                            expect(detailsViewMock.calls.populateWithState) == true
                            expect(detailsViewMock.arguments.states) == [.loading, .content]
                            expect(detailsViewMock.calls.populateWithMovie) == true
                        }
                    }

                    context("movie is favourite") {
                        it("populates view with loading state, populates view with content state, movie and title") {
                            getMovieUseCaseMock.settings.movie = Mock.movie(isFavourite: true)

                            detailsPresenter.getContent()

                            expect(getMovieUseCaseMock.calls.execute) == true
                            expect(getMovieUseCaseMock.arguments.id) == id

                            expect(detailsViewMock.calls.populateWithState) == true
                            expect(detailsViewMock.arguments.states) == [.loading, .content]
                            expect(detailsViewMock.calls.populateWithMovie) == true
                        }
                    }
                }
            }

            context("not first time") {
                beforeEach {
                    detailsPresenter.getContent()
                }

                context("get movie use case executes -> movie") {
                    it("populates view with loading state, populates view with content state, movie and title") {
                        detailsPresenter.getContent()

                        expect(getMovieUseCaseMock.calls.execute) == true
                        expect(getMovieUseCaseMock.arguments.id) == id

                        expect(detailsViewMock.calls.populateWithState) == true
                        expect(detailsViewMock.arguments.states) == [.loading, .content, .content]
                        expect(detailsViewMock.calls.populateWithMovie) == true
                    }
                }
            }
        }

        describe("try again") {
            context("get movie use case executes -> error") {
                it("populates view with loading state, populates view with error state") {
                    getMovieUseCaseMock.settings.shouldReturnError = true

                    detailsPresenter.tryAgain()

                    expect(getMovieUseCaseMock.calls.execute) == true
                    expect(getMovieUseCaseMock.arguments.id) == id

                    expect(detailsViewMock.calls.populateWithState) == true
                    expect(detailsViewMock.arguments.states) == [.loading, .error(Mock.Error.force)]
                }
            }

            context("get movie use case executes -> movie") {
                context("movie is not favourite") {
                    it("populates view with loading state, populates view with content state, movie and title") {
                        detailsPresenter.tryAgain()

                        expect(getMovieUseCaseMock.calls.execute) == true
                        expect(getMovieUseCaseMock.arguments.id) == id

                        expect(detailsViewMock.calls.populateWithState) == true
                        expect(detailsViewMock.arguments.states) == [.loading, .content]
                        expect(detailsViewMock.calls.populateWithMovie) == true
                    }
                }
            }
        }

        describe("mark movie") {
            context("content was not got") {
                it("ignores execution") {
                    detailsPresenter.markMovie(state: .favourites)

                    expect(changeMovieFavouriteStateUseCaseMock.calls.execute) == false
                }
            }

            context("content was got") {
                beforeEach {
                    detailsPresenter.getContent()
                }

                context("change movie favourite state use case executes -> error") {
                    it("present favourite error in view") {
                        changeMovieFavouriteStateUseCaseMock.settings.shouldReturnError = true

                        detailsPresenter.markMovie(state: .favourites)

                        expect(changeMovieFavouriteStateUseCaseMock.calls.execute) == true
                        expect(detailsViewMock.calls.presentMarkError) == true
                    }
                }

                context("change movie favourite state use case executes -> movie") {
                    it("populates view with content state, movie and title") {
                        detailsPresenter.markMovie(state: .watchlist)

                        expect(changeMovieInWatchlistStateUseCaseMock.calls.execute) == true
                        expect(detailsViewMock.calls.populateWithMovie) == true
                    }
                }
            }
        }
    }
}
