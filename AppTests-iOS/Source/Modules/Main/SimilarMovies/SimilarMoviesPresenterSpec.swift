//
//  SimilarMoviesPresenterSpec.swift
//  MoviesTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Movies

class SimilarMoviesPresenterSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        let id = "id"

        var similarMoviesPresenter: SimilarMoviesPresenter!
        var getSimilarMoviesUseCaseMock: GetSimilarMoviesUseCaseMock!
        var similarMoviesViewMock: SimilarMoviesViewMock!

        beforeEach {
            getSimilarMoviesUseCaseMock = GetSimilarMoviesUseCaseMock()
            similarMoviesPresenter = SimilarMoviesPresenter(getSimilarMoviesUseCase: getSimilarMoviesUseCaseMock)

            similarMoviesViewMock = SimilarMoviesViewMock()
            similarMoviesPresenter.view = similarMoviesViewMock
            similarMoviesPresenter.id = id
        }

        describe("get content") {
            context("get similar movies use case executes -> error") {
                it("populates view with loading state, populates view with error state") {
                    getSimilarMoviesUseCaseMock.settings.shouldReturnError = true

                    similarMoviesPresenter.getContent()

                    expect(getSimilarMoviesUseCaseMock.calls.execute) == true
                    expect(getSimilarMoviesUseCaseMock.arguments.id) == id

                    expect(similarMoviesViewMock.calls.populateWithState) == true
                    expect(similarMoviesViewMock.arguments.states) == [.loading, .error(Mock.Error.force)]
                }
            }

            context("get similar movies use case executes -> empty array") {
                it("populates view with loading state, populates view with empty state and movies") {
                    getSimilarMoviesUseCaseMock.settings.shouldReturnEmpty = true

                    similarMoviesPresenter.getContent()

                    expect(getSimilarMoviesUseCaseMock.calls.execute) == true
                    expect(getSimilarMoviesUseCaseMock.arguments.id) == id

                    expect(similarMoviesViewMock.calls.populateWithState) == true
                    expect(similarMoviesViewMock.arguments.states) == [.loading, .empty]
                    expect(similarMoviesViewMock.calls.populateWithMovies) == true
                }
            }

            context("get similar movies use case executes -> movies") {
                it("populates view with loading state, populates view with content state and movies") {
                    similarMoviesPresenter.getContent()

                    expect(getSimilarMoviesUseCaseMock.calls.execute) == true
                    expect(getSimilarMoviesUseCaseMock.arguments.id) == id

                    expect(similarMoviesViewMock.calls.populateWithState) == true
                    expect(similarMoviesViewMock.arguments.states) == [.loading, .content]
                    expect(similarMoviesViewMock.calls.populateWithMovies) == true
                }
            }
        }

        describe("try again") {
            context("get similar movies use case executes -> error") {
                it("populates view with loading state, populates view with error state") {
                    getSimilarMoviesUseCaseMock.settings.shouldReturnError = true

                    similarMoviesPresenter.tryAgain()

                    expect(getSimilarMoviesUseCaseMock.calls.execute) == true
                    expect(getSimilarMoviesUseCaseMock.arguments.id) == id

                    expect(similarMoviesViewMock.calls.populateWithState) == true
                    expect(similarMoviesViewMock.arguments.states) == [.loading, .error(Mock.Error.force)]
                }
            }

            context("get similar movies use case executes -> empty array") {
                it("populates view with loading state, populates view with empty state and movies") {
                    getSimilarMoviesUseCaseMock.settings.shouldReturnEmpty = true

                    similarMoviesPresenter.tryAgain()

                    expect(getSimilarMoviesUseCaseMock.calls.execute) == true
                    expect(getSimilarMoviesUseCaseMock.arguments.id) == id

                    expect(similarMoviesViewMock.calls.populateWithState) == true
                    expect(similarMoviesViewMock.arguments.states) == [.loading, .empty]
                    expect(similarMoviesViewMock.calls.populateWithMovies) == true
                }
            }

            context("get similar movies use case executes -> movies") {
                it("populates view with loading state, populates view with content state and movies") {
                    similarMoviesPresenter.tryAgain()

                    expect(getSimilarMoviesUseCaseMock.calls.execute) == true
                    expect(getSimilarMoviesUseCaseMock.arguments.id) == id

                    expect(similarMoviesViewMock.calls.populateWithState) == true
                    expect(similarMoviesViewMock.arguments.states) == [.loading, .content]
                    expect(similarMoviesViewMock.calls.populateWithMovies) == true
                }
            }
        }
    }
}
