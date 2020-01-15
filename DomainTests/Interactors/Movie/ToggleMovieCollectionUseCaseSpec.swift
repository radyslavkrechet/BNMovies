//
//  ToggleMovieCollectionUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 27.11.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class ToggleMovieCollectionUseCaseSpec: QuickSpec {
    override func spec() {
        var toggleMovieCollectionUseCase: ToggleMovieCollectionUseCase!
        var movieRepositoryMock: MovieRepositoryMock!

        beforeEach {
            movieRepositoryMock = MovieRepositoryMock()
            toggleMovieCollectionUseCase = ToggleMovieCollectionUseCase(movieRepository: movieRepositoryMock)
        }

        describe("execute") {
            let movie = Mock.movie
            let collection = Movie.Collection.favourites

            context("movie repository toggles movie collection -> error") {
                it("returns error") {
                    movieRepositoryMock.settings.shouldReturnError = true

                    waitUntil { done in
                        toggleMovieCollectionUseCase.execute(with: movie, collection: collection) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.toggleMovieCollection) == true
                            expect(movieRepositoryMock.arguments.movie) == movie
                            expect(movieRepositoryMock.arguments.collection) == collection
                            done()
                        }
                    }
                }
            }

            context("movie repository toggles movie collection -> movie") {
                it("returns movie") {
                    waitUntil { done in
                        toggleMovieCollectionUseCase.execute(with: movie, collection: collection) { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.toggleMovieCollection) == true
                            expect(movieRepositoryMock.arguments.movie) == movie
                            expect(movieRepositoryMock.arguments.collection) == collection
                            done()
                        }
                    }
                }
            }
        }
    }
}
