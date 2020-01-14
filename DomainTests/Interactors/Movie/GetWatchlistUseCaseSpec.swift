//
//  GetWatchlistUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 14.01.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class GetWatchlistUseCaseSpec: QuickSpec {
    override func spec() {
        var getWatchlistUseCase: GetWatchlistUseCase!
        var movieRepositoryMock: MovieRepositoryMock!

        beforeEach {
            movieRepositoryMock = MovieRepositoryMock()
            getWatchlistUseCase = GetWatchlistUseCase(movieRepository: movieRepositoryMock)
        }

        describe("execute") {
            context("movie repository gets watchlist -> error") {
                it("returns error") {
                    movieRepositoryMock.settings.shouldReturnError = true

                    waitUntil { done in
                        getWatchlistUseCase.execute { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.getWatchlist) == true
                            done()
                        }
                    }
                }
            }

            context("movie repository gets watchlist -> movies") {
                it("returns movies") {
                    waitUntil { done in
                        getWatchlistUseCase.execute { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.getWatchlist) == true
                            done()
                        }
                    }
                }
            }
        }
    }
}
