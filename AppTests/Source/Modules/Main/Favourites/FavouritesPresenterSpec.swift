//
//  FavouritesPresenterSpec.swift
//  BoilerplateTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Boilerplate

class FavouritesPresenterSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var favouritesPresenter: FavouritesPresenter!
        var getFavouritesUseCaseMock: GetFavouritesUseCaseMock!
        var favouritesViewMock: FavouritesViewMock!

        beforeEach {
            getFavouritesUseCaseMock = GetFavouritesUseCaseMock()
            favouritesPresenter = FavouritesPresenter(getFavouritesUseCase: getFavouritesUseCaseMock)

            favouritesViewMock = FavouritesViewMock()
            favouritesPresenter.view = favouritesViewMock
        }

        describe("get content") {
            context("first time") {
                context("get favourites use case executes -> error") {
                    it("populates view with loading state, populates view with error state") {
                        getFavouritesUseCaseMock.settings.shouldReturnError = true

                        favouritesPresenter.getContent()

                        expect(getFavouritesUseCaseMock.calls.execute) == true
                        expect(favouritesViewMock.calls.populateWithState) == true
                        expect(favouritesViewMock.arguments.states) == [.loading, .error(Mock.Error.force)]
                    }
                }

                context("get favourites use case executes -> empty array") {
                    it("populates view with loading state, populates view with empty state and movies") {
                        getFavouritesUseCaseMock.settings.shouldReturnEmpty = true

                        favouritesPresenter.getContent()

                        expect(getFavouritesUseCaseMock.calls.execute) == true
                        expect(favouritesViewMock.calls.populateWithState) == true
                        expect(favouritesViewMock.arguments.states) == [.loading, .empty]
                        expect(favouritesViewMock.calls.populateWithMovies) == true
                    }
                }

                context("get favourites use case executes -> movies") {
                    it("populates view with loading state, populates view with content state and movies") {
                        favouritesPresenter.getContent()

                        expect(getFavouritesUseCaseMock.calls.execute) == true
                        expect(favouritesViewMock.calls.populateWithState) == true
                        expect(favouritesViewMock.arguments.states) == [.loading, .content]
                        expect(favouritesViewMock.calls.populateWithMovies) == true
                    }
                }
            }

            context("not first time") {
                context("get favourites use case executes -> movies") {
                    it("populates view with content state and movies") {
                        favouritesPresenter.getContent()
                        favouritesPresenter.getContent()

                        expect(getFavouritesUseCaseMock.calls.execute) == true
                        expect(favouritesViewMock.calls.populateWithState) == true
                        expect(favouritesViewMock.arguments.states) == [.loading, .content, .content]
                        expect(favouritesViewMock.calls.populateWithMovies) == true
                    }
                }
            }
        }

        describe("try again") {
            context("first time") {
                context("get favourites use case executes -> error") {
                    it("populates view with loading state, populates view with error state") {
                        getFavouritesUseCaseMock.settings.shouldReturnError = true

                        favouritesPresenter.tryAgain()

                        expect(getFavouritesUseCaseMock.calls.execute) == true
                        expect(favouritesViewMock.calls.populateWithState) == true
                        expect(favouritesViewMock.arguments.states) == [.loading, .error(Mock.Error.force)]
                    }
                }

                context("get favourites use case executes -> empty array") {
                    it("populates view with loading state, populates view with empty state and movies") {
                        getFavouritesUseCaseMock.settings.shouldReturnEmpty = true

                        favouritesPresenter.tryAgain()

                        expect(getFavouritesUseCaseMock.calls.execute) == true
                        expect(favouritesViewMock.calls.populateWithState) == true
                        expect(favouritesViewMock.arguments.states) == [.loading, .empty]
                        expect(favouritesViewMock.calls.populateWithMovies) == true
                    }
                }

                context("get favourites use case executes -> movies") {
                    it("populates view with loading state, populates view with content state and movies") {
                        favouritesPresenter.tryAgain()

                        expect(getFavouritesUseCaseMock.calls.execute) == true
                        expect(favouritesViewMock.calls.populateWithState) == true
                        expect(favouritesViewMock.arguments.states) == [.loading, .content]
                        expect(favouritesViewMock.calls.populateWithMovies) == true
                    }
                }
            }

            context("not first time") {
                context("get favourites use case executes -> movies") {
                    it("populates view with loading state, populates view with content state and movies") {
                        favouritesPresenter.getContent()
                        favouritesPresenter.tryAgain()

                        expect(getFavouritesUseCaseMock.calls.execute) == true
                        expect(favouritesViewMock.calls.populateWithState) == true
                        expect(favouritesViewMock.arguments.states) == [.loading, .content, .loading, .content]
                        expect(favouritesViewMock.calls.populateWithMovies) == true
                    }
                }
            }
        }
    }
}
