//
//  DetailsPresenterSpec.swift
//  Movies
//
//  Created by Radyslav Krechet on 10.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain

@testable import Movies

class DetailsPresenterSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        let id = "id"

        var detailsPresenter: DetailsPresenter!
        var getMovieUseCaseMock: GetMovieUseCaseMock!
        var toggleMovieCollectionUseCaseMock: ToggleMovieCollectionUseCaseMock!
        var detailsViewMock: DetailsViewMock!

        beforeEach {
            getMovieUseCaseMock = GetMovieUseCaseMock()
            toggleMovieCollectionUseCaseMock = ToggleMovieCollectionUseCaseMock()
            detailsPresenter = DetailsPresenter(getMovieUseCase: getMovieUseCaseMock,
                                                toggleMovieCollectionUseCase: toggleMovieCollectionUseCaseMock)

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
                    it("populates view with loading state, populates view with content state and movie") {
                        detailsPresenter.getContent()

                        expect(getMovieUseCaseMock.calls.execute) == true
                        expect(getMovieUseCaseMock.arguments.id) == id

                        expect(detailsViewMock.calls.populateWithState) == true
                        expect(detailsViewMock.arguments.states) == [.loading, .content]
                        expect(detailsViewMock.calls.populateWithMovie) == true
                    }
                }
            }

            context("not first time") {
                beforeEach {
                    detailsPresenter.getContent()
                }

                context("get movie use case executes -> movie") {
                    it("populates view with loading state, populates view with content state and movie") {
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
                it("populates view with loading state, populates view with content state and movie") {
                    detailsPresenter.tryAgain()

                    expect(getMovieUseCaseMock.calls.execute) == true
                    expect(getMovieUseCaseMock.arguments.id) == id

                    expect(detailsViewMock.calls.populateWithState) == true
                    expect(detailsViewMock.arguments.states) == [.loading, .content]
                    expect(detailsViewMock.calls.populateWithMovie) == true
                }
            }
        }

        describe("mark movie") {
            let collection = Movie.Collection.favourites

            context("content was not got") {
                it("ignores execution") {
                    detailsPresenter.markMovie(collection)

                    expect(toggleMovieCollectionUseCaseMock.calls.execute) == false
                }
            }

            context("content was got") {
                beforeEach {
                    detailsPresenter.getContent()
                }

                context("toggle movie collection use case executes -> error") {
                    it("present mark error in view") {
                        toggleMovieCollectionUseCaseMock.settings.shouldReturnError = true

                        detailsPresenter.markMovie(collection)

                        expect(toggleMovieCollectionUseCaseMock.calls.execute) == true
                        expect(detailsViewMock.calls.presentMarkError) == true
                    }
                }

                context("toggle movie collection use case executes -> movie") {
                    it("populates view with content state and movie") {
                        detailsPresenter.markMovie(collection)

                        expect(toggleMovieCollectionUseCaseMock.calls.execute) == true
                        expect(detailsViewMock.calls.populateWithMovie) == true
                    }
                }
            }
        }
    }
}
