//
//  CollectionPresenterSpec.swift
//  MoviesTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain

@testable import Movies

class CollectionPresenterSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var collectionPresenter: CollectionPresenter!
        var getCollectionUseCaseMock: GetCollectionUseCaseMock!
        var collectionViewMock: CollectionViewMock!

        beforeEach {
            getCollectionUseCaseMock = GetCollectionUseCaseMock()
            collectionPresenter = CollectionPresenter(getCollectionUseCase: getCollectionUseCaseMock)

            collectionViewMock = CollectionViewMock()
            collectionPresenter.view = collectionViewMock
            collectionPresenter.collection = .favourites
        }

        describe("get content") {
            context("first time") {
                context("get collection use case executes -> error") {
                    it("populates view with loading state, populates view with error state") {
                        getCollectionUseCaseMock.settings.shouldReturnError = true

                        collectionPresenter.getContent()

                        expect(getCollectionUseCaseMock.calls.execute) == true
                        expect(collectionViewMock.calls.populateWithState) == true
                        expect(collectionViewMock.arguments.states) == [.loading, .error(Mock.Error.force)]
                    }
                }

                context("get collection use case executes -> empty array") {
                    it("populates view with loading state, populates view with empty state and movies") {
                        getCollectionUseCaseMock.settings.shouldReturnEmpty = true

                        collectionPresenter.getContent()

                        expect(getCollectionUseCaseMock.calls.execute) == true
                        expect(collectionViewMock.calls.populateWithState) == true
                        expect(collectionViewMock.arguments.states) == [.loading, .empty]
                        expect(collectionViewMock.calls.populateWithMovies) == true
                    }
                }

                context("get collection use case executes -> movies") {
                    it("populates view with loading state, populates view with content state and movies") {
                        collectionPresenter.getContent()

                        expect(getCollectionUseCaseMock.calls.execute) == true
                        expect(collectionViewMock.calls.populateWithState) == true
                        expect(collectionViewMock.arguments.states) == [.loading, .content]
                        expect(collectionViewMock.calls.populateWithMovies) == true
                    }
                }
            }

            context("not first time") {
                context("get collection use case executes -> movies") {
                    it("populates view with content state and movies") {
                        collectionPresenter.getContent()
                        collectionPresenter.getContent()

                        expect(getCollectionUseCaseMock.calls.execute) == true
                        expect(collectionViewMock.calls.populateWithState) == true
                        expect(collectionViewMock.arguments.states) == [.loading, .content, .content]
                        expect(collectionViewMock.calls.populateWithMovies) == true
                    }
                }
            }
        }

        describe("try again") {
            context("first time") {
                context("get collection use case executes -> error") {
                    it("populates view with loading state, populates view with error state") {
                        getCollectionUseCaseMock.settings.shouldReturnError = true

                        collectionPresenter.tryAgain()

                        expect(getCollectionUseCaseMock.calls.execute) == true
                        expect(collectionViewMock.calls.populateWithState) == true
                        expect(collectionViewMock.arguments.states) == [.loading, .error(Mock.Error.force)]
                    }
                }

                context("get collection use case executes -> empty array") {
                    it("populates view with loading state, populates view with empty state and movies") {
                        getCollectionUseCaseMock.settings.shouldReturnEmpty = true

                        collectionPresenter.tryAgain()

                        expect(getCollectionUseCaseMock.calls.execute) == true
                        expect(collectionViewMock.calls.populateWithState) == true
                        expect(collectionViewMock.arguments.states) == [.loading, .empty]
                        expect(collectionViewMock.calls.populateWithMovies) == true
                    }
                }

                context("get collection use case executes -> movies") {
                    it("populates view with loading state, populates view with content state and movies") {
                        collectionPresenter.tryAgain()

                        expect(getCollectionUseCaseMock.calls.execute) == true
                        expect(collectionViewMock.calls.populateWithState) == true
                        expect(collectionViewMock.arguments.states) == [.loading, .content]
                        expect(collectionViewMock.calls.populateWithMovies) == true
                    }
                }
            }

            context("not first time") {
                context("get collection use case executes -> movies") {
                    it("populates view with loading state, populates view with content state and movies") {
                        collectionPresenter.getContent()
                        collectionPresenter.tryAgain()

                        expect(getCollectionUseCaseMock.calls.execute) == true
                        expect(collectionViewMock.calls.populateWithState) == true
                        expect(collectionViewMock.arguments.states) == [.loading, .content, .loading, .content]
                        expect(collectionViewMock.calls.populateWithMovies) == true
                    }
                }
            }
        }
    }
}
