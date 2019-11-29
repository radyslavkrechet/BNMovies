//
//  GetMoviesUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 27.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class GetMoviesUseCaseSpec: QuickSpec {
    override func spec() {
        describe("execute") {
            let page = 0
            var getMoviesUseCase: GetMoviesUseCase!
            var movieRepositoryMock: MovieRepositoryMock!

            beforeEach {
                movieRepositoryMock = MovieRepositoryMock()
                getMoviesUseCase = GetMoviesUseCase(movieRepository: movieRepositoryMock)
            }

            context("movie repository gets movies -> error") {
                it("returns error") {
                    movieRepositoryMock.settings.shouldReturnError = true

                    waitUntil { done in
                        getMoviesUseCase.execute(with: page) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.getMovies) == true
                            expect(movieRepositoryMock.arguments.page) == page
                            done()
                        }
                    }
                }
            }

            context("movie repository gets movies -> movies") {
                it("returns movies") {
                    waitUntil { done in
                        getMoviesUseCase.execute(with: page) { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.getMovies) == true
                            expect(movieRepositoryMock.arguments.page) == page
                            done()
                        }
                    }
                }
            }
        }
    }
}
