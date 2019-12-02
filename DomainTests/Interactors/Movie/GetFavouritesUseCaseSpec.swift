//
//  GetFavouritesUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 27.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class GetFavouritesUseCaseSpec: QuickSpec {
    override func spec() {
        var getFavouritesUseCase: GetFavouritesUseCase!
        var movieRepositoryMock: MovieRepositoryMock!

        beforeEach {
            movieRepositoryMock = MovieRepositoryMock()
            getFavouritesUseCase = GetFavouritesUseCase(movieRepository: movieRepositoryMock)
        }

        describe("execute") {
            context("movie repository gets favourites -> error") {
                it("returns error") {
                    movieRepositoryMock.settings.shouldReturnError = true

                    waitUntil { done in
                        getFavouritesUseCase.execute { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.getFavourites) == true
                            done()
                        }
                    }
                }
            }

            context("movie repository gets favourites -> movies") {
                it("returns movies") {
                    waitUntil { done in
                        getFavouritesUseCase.execute { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.getFavourites) == true
                            done()
                        }
                    }
                }
            }
        }
    }
}
