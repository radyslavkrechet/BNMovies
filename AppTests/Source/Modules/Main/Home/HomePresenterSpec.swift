//
//  HomePresenterSpec.swift
//  BoilerplateTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain

@testable import Boilerplate

class HomePresenterSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var homePresenter: HomePresenter!
        var getMoviesUseCaseMock: GetMoviesUseCaseMock!
        var paginationServiceMock: PaginationServiceMock!
        var homeViewMock: HomeViewMock!

        beforeEach {
            getMoviesUseCaseMock = GetMoviesUseCaseMock()
            paginationServiceMock = PaginationServiceMock()
            homePresenter = HomePresenter(getMoviesUseCase: getMoviesUseCaseMock,
                                          paginationService: paginationServiceMock)

            homeViewMock = HomeViewMock()
            homePresenter.view = homeViewMock
        }

        describe("get content") {
            context("get movies use case executes -> error") {
                it("populates view with loading state, populates view with error state") {
                    getMoviesUseCaseMock.settings.shouldReturnError = true

                    homePresenter.getContent()

                    expect(paginationServiceMock.calls.startLoading) == true
                    expect(getMoviesUseCaseMock.calls.execute) == true
                    expect(getMoviesUseCaseMock.arguments.page) == paginationServiceMock.page

                    expect(homeViewMock.calls.populateWithState) == true
                    expect(homeViewMock.arguments.states) == [.loading, .error(Mock.Error.force)]
                }
            }

            context("get movies use case executes -> empty array") {
                it("populates view with loading state, populates view with empty state and movies") {
                    getMoviesUseCaseMock.settings.shouldReturnEmpty = true

                    homePresenter.getContent()

                    expect(paginationServiceMock.calls.startLoading) == true
                    expect(getMoviesUseCaseMock.calls.execute) == true
                    expect(getMoviesUseCaseMock.arguments.category) == .popular
                    expect(getMoviesUseCaseMock.arguments.page) == paginationServiceMock.page

                    expect(homeViewMock.calls.populateWithState) == true
                    expect(homeViewMock.arguments.states) == [.loading, .empty]
                    expect(homeViewMock.calls.populateWithMovies) == true

                    expect(paginationServiceMock.calls.stopLoading) == true
                    expect(paginationServiceMock.arguments.itemsCount) == 0
                }
            }

            context("get movies use case executes -> movies") {
                it("populates view with loading state, populates view with content state and movies") {
                    homePresenter.getContent()

                    expect(paginationServiceMock.calls.startLoading) == true
                    expect(getMoviesUseCaseMock.calls.execute) == true
                    expect(getMoviesUseCaseMock.arguments.category) == .popular
                    expect(getMoviesUseCaseMock.arguments.page) == paginationServiceMock.page

                    expect(homeViewMock.calls.populateWithState) == true
                    expect(homeViewMock.arguments.states) == [.loading, .content]
                    expect(homeViewMock.calls.populateWithMovies) == true

                    expect(paginationServiceMock.calls.stopLoading) == true
                    expect(paginationServiceMock.arguments.itemsCount) > 0
                }
            }
        }

        describe("get more content") {
            beforeEach {
                homePresenter.getContent()
            }

            context("first time") {
                context("get movies use case executes -> error") {
                    it("populates view with error state") {
                        getMoviesUseCaseMock.settings.shouldReturnError = true

                        homePresenter.getMoreContent()

                        expect(paginationServiceMock.calls.startLoading) == true
                        expect(getMoviesUseCaseMock.calls.execute) == true
                        expect(getMoviesUseCaseMock.arguments.category) == .popular
                        expect(getMoviesUseCaseMock.arguments.page) == paginationServiceMock.page

                        expect(homeViewMock.calls.populateWithState) == true
                        expect(homeViewMock.arguments.states) == [.loading, .content, .error(Mock.Error.force)]
                    }
                }

                context("get movies use case executes -> empty array") {
                    it("populates view with content state and movies") {
                        getMoviesUseCaseMock.settings.shouldReturnEmpty = true

                        homePresenter.getMoreContent()

                        expect(paginationServiceMock.calls.startLoading) == true
                        expect(getMoviesUseCaseMock.calls.execute) == true
                        expect(getMoviesUseCaseMock.arguments.category) == .popular
                        expect(getMoviesUseCaseMock.arguments.page) == paginationServiceMock.page

                        expect(homeViewMock.calls.populateWithState) == true
                        expect(homeViewMock.arguments.states) == [.loading, .content, .content]
                        expect(homeViewMock.calls.populateWithMovies) == true

                        expect(paginationServiceMock.calls.stopLoading) == true
                        expect(paginationServiceMock.arguments.itemsCount) == 0
                    }
                }

                context("get movies use case executes -> movies") {
                    it("populates view with content state and movies") {
                        homePresenter.getMoreContent()

                        expect(paginationServiceMock.calls.startLoading) == true
                        expect(getMoviesUseCaseMock.calls.execute) == true
                        expect(getMoviesUseCaseMock.arguments.category) == .popular
                        expect(getMoviesUseCaseMock.arguments.page) == paginationServiceMock.page

                        expect(homeViewMock.calls.populateWithState) == true
                        expect(homeViewMock.arguments.states) == [.loading, .content, .content]
                        expect(homeViewMock.calls.populateWithMovies) == true

                        expect(paginationServiceMock.calls.stopLoading) == true
                        expect(paginationServiceMock.arguments.itemsCount) > 0
                    }
                }
            }

            context("not first time") {
                context("last execution returns empty array") {
                    it("ignores execution") {
                        getMoviesUseCaseMock.settings.shouldReturnEmpty = true
                        homePresenter.getMoreContent()

                        homePresenter.getMoreContent()

                        expect(homeViewMock.arguments.states) == [.loading, .content, .content]
                    }
                }
            }
        }

        describe("refresh content") {
            beforeEach {
                homePresenter.getContent()
            }

            context("get movies use case executes -> error") {
                it("populates view with error state") {
                    getMoviesUseCaseMock.settings.shouldReturnError = true

                    homePresenter.refreshContent()

                    expect(paginationServiceMock.calls.reset) == true
                    expect(paginationServiceMock.calls.startLoading) == true
                    expect(getMoviesUseCaseMock.calls.execute) == true
                    expect(getMoviesUseCaseMock.arguments.category) == .popular
                    expect(getMoviesUseCaseMock.arguments.page) == paginationServiceMock.page

                    expect(homeViewMock.calls.populateWithState) == true
                    expect(homeViewMock.arguments.states) == [.loading, .content, .error(Mock.Error.force)]
                }
            }

            context("get movies use case executes -> movies") {
                it("populates view with content state and movies") {
                    homePresenter.refreshContent()

                    expect(paginationServiceMock.calls.reset) == true
                    expect(paginationServiceMock.calls.startLoading) == true
                    expect(getMoviesUseCaseMock.calls.execute) == true
                    expect(getMoviesUseCaseMock.arguments.category) == .popular
                    expect(getMoviesUseCaseMock.arguments.page) == paginationServiceMock.page

                    expect(homeViewMock.calls.populateWithState) == true
                    expect(homeViewMock.arguments.states) == [.loading, .content, .content]
                    expect(homeViewMock.calls.populateWithMovies) == true

                    expect(paginationServiceMock.calls.stopLoading) == true
                    expect(paginationServiceMock.arguments.itemsCount) > 0
                }
            }
        }

        describe("try again") {
            beforeEach {
                getMoviesUseCaseMock.settings.shouldReturnError = true
                homePresenter.getContent()
                getMoviesUseCaseMock.settings.shouldReturnError = false
            }

            context("get movies use case executes -> error") {
                it("populates view with error state") {
                    getMoviesUseCaseMock.settings.shouldReturnError = true

                    homePresenter.tryAgain()

                    expect(paginationServiceMock.calls.reset) == true
                    expect(paginationServiceMock.calls.startLoading) == true
                    expect(getMoviesUseCaseMock.calls.execute) == true
                    expect(getMoviesUseCaseMock.arguments.category) == .popular
                    expect(getMoviesUseCaseMock.arguments.page) == paginationServiceMock.page

                    expect(homeViewMock.calls.populateWithState) == true
                    expect(homeViewMock.arguments.states) == [.loading,
                                                              .error(Mock.Error.force),
                                                              .loading,
                                                              .error(Mock.Error.force)]
                }
            }

            context("get movies use case executes -> empty array") {
                it("populates view with content state and movies") {
                    getMoviesUseCaseMock.settings.shouldReturnEmpty = true

                    homePresenter.tryAgain()

                    expect(paginationServiceMock.calls.reset) == true
                    expect(paginationServiceMock.calls.startLoading) == true
                    expect(getMoviesUseCaseMock.calls.execute) == true
                    expect(getMoviesUseCaseMock.arguments.category) == .popular
                    expect(getMoviesUseCaseMock.arguments.page) == paginationServiceMock.page

                    expect(homeViewMock.calls.populateWithState) == true
                    expect(homeViewMock.arguments.states) == [.loading, .error(Mock.Error.force), .loading, .empty]
                    expect(homeViewMock.calls.populateWithMovies) == true

                    expect(paginationServiceMock.calls.stopLoading) == true
                    expect(paginationServiceMock.arguments.itemsCount) == 0
                }
            }

            context("get movies use case executes -> movies") {
                it("populates view with content state and movies") {
                    homePresenter.tryAgain()

                    expect(paginationServiceMock.calls.reset) == true
                    expect(paginationServiceMock.calls.startLoading) == true
                    expect(getMoviesUseCaseMock.calls.execute) == true
                    expect(getMoviesUseCaseMock.arguments.category) == .popular
                    expect(getMoviesUseCaseMock.arguments.page) == paginationServiceMock.page

                    expect(homeViewMock.calls.populateWithState) == true
                    expect(homeViewMock.arguments.states) == [.loading, .error(Mock.Error.force), .loading, .content]
                    expect(homeViewMock.calls.populateWithMovies) == true

                    expect(paginationServiceMock.calls.stopLoading) == true
                    expect(paginationServiceMock.arguments.itemsCount) > 0
                }
            }
        }

        describe("change movie category") {
            let category = Movie.Category.topRated

            beforeEach {
                homePresenter.getContent()
            }

            context("get movies use case executes -> error") {
                it("populates view with error state") {
                    getMoviesUseCaseMock.settings.shouldReturnError = true

                    homePresenter.changeMovieCategory(category)

                    expect(paginationServiceMock.calls.reset) == true
                    expect(paginationServiceMock.calls.startLoading) == true
                    expect(getMoviesUseCaseMock.calls.execute) == true
                    expect(getMoviesUseCaseMock.arguments.category) == category
                    expect(getMoviesUseCaseMock.arguments.page) == paginationServiceMock.page

                    expect(homeViewMock.calls.populateWithState) == true
                    expect(homeViewMock.arguments.states) == [.loading, .content, .error(Mock.Error.force)]
                }
            }

            context("get movies use case executes -> movies") {
                it("populates view with content state and movies") {
                    homePresenter.changeMovieCategory(category)

                    expect(paginationServiceMock.calls.reset) == true
                    expect(paginationServiceMock.calls.startLoading) == true
                    expect(getMoviesUseCaseMock.calls.execute) == true
                    expect(getMoviesUseCaseMock.arguments.category) == category
                    expect(getMoviesUseCaseMock.arguments.page) == paginationServiceMock.page

                    expect(homeViewMock.calls.populateWithState) == true
                    expect(homeViewMock.arguments.states) == [.loading, .content, .content]
                    expect(homeViewMock.calls.populateWithMovies) == true

                    expect(paginationServiceMock.calls.stopLoading) == true
                    expect(paginationServiceMock.arguments.itemsCount) > 0
                }
            }
        }
    }
}
