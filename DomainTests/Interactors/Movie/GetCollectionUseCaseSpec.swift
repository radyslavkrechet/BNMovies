//
//  GetCollectionUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 27.11.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class GetCollectionUseCaseSpec: QuickSpec {
    override func spec() {
        var getCollectionUseCase: GetCollectionUseCase!
        var movieRepositoryMock: MovieRepositoryMock!

        beforeEach {
            movieRepositoryMock = MovieRepositoryMock()
            getCollectionUseCase = GetCollectionUseCase(movieRepository: movieRepositoryMock)
        }

        describe("execute") {
            let collection = Movie.Collection.favourites

            context("movie repository gets collection -> error") {
                it("returns error") {
                    movieRepositoryMock.settings.shouldReturnError = true

                    waitUntil { done in
                        getCollectionUseCase.execute(with: collection) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.getCollection) == true
                            expect(movieRepositoryMock.arguments.collection) == collection
                            done()
                        }
                    }
                }
            }

            context("movie repository gets collection -> movies") {
                it("returns movies") {
                    waitUntil { done in
                        getCollectionUseCase.execute(with: collection) { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.getCollection) == true
                            expect(movieRepositoryMock.arguments.collection) == collection
                            done()
                        }
                    }
                }
            }
        }
    }
}
