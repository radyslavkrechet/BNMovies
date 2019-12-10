//
//  DetailsPresenterSpec.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 10.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Boilerplate

class DetailsPresenterSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        let id = "id"

        var detailsPresenter: DetailsPresenter!
        var getMovieUseCaseMock: GetMovieUseCaseMock!
        var changeMovieFavouriteStateUseCaseMock: ChangeMovieFavouriteStateUseCaseMock!
        var detailsViewMock: DetailsViewMock!

        beforeEach {
            getMovieUseCaseMock = GetMovieUseCaseMock()
            changeMovieFavouriteStateUseCaseMock = ChangeMovieFavouriteStateUseCaseMock()
            detailsPresenter = DetailsPresenter(getMovieUseCase: getMovieUseCaseMock,
                                                changeMovieFavouriteStateUseCase: changeMovieFavouriteStateUseCaseMock)

            detailsViewMock = DetailsViewMock()
            detailsPresenter.view = detailsViewMock
            detailsPresenter.id = id
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
                            expect(detailsViewMock.calls.populateWithFavouriteTitle) == true
                            expect(detailsViewMock.arguments.favouriteTitle)
                                == "DetailsViewController.favouriteTitle.add".localized
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
                            expect(detailsViewMock.calls.populateWithFavouriteTitle) == true
                            expect(detailsViewMock.arguments.favouriteTitle)
                                == "DetailsViewController.favouriteTitle.remove".localized
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
                        expect(detailsViewMock.calls.populateWithFavouriteTitle) == true
                        expect(detailsViewMock.arguments.favouriteTitle)
                            == "DetailsViewController.favouriteTitle.add".localized
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
                        expect(detailsViewMock.calls.populateWithFavouriteTitle) == true
                        expect(detailsViewMock.arguments.favouriteTitle)
                            == "DetailsViewController.favouriteTitle.add".localized
                    }
                }
            }
        }

        describe("mark movie as favourite") {
            context("content was not got") {
                it("ignores execution") {
                    detailsPresenter.markMovieAsFavourite()

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

                        detailsPresenter.markMovieAsFavourite()

                        expect(changeMovieFavouriteStateUseCaseMock.calls.execute) == true
                        expect(detailsViewMock.calls.presentFavouriteError) == true
                    }
                }

                context("change movie favourite state use case executes -> movie") {
                    it("populates view with content state, movie and title") {
                        detailsPresenter.markMovieAsFavourite()

                        expect(changeMovieFavouriteStateUseCaseMock.calls.execute) == true
                        expect(detailsViewMock.calls.populateWithMovie) == true
                        expect(detailsViewMock.calls.populateWithFavouriteTitle) == true
                    }
                }
            }
        }
    }
}
