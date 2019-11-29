//
//  GetSimilarMoviesUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 27.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class GetSimilarMoviesUseCaseSpec: QuickSpec {
    override func spec() {
        describe("execute") {
            let id = "id"
            var getSimilarMoviesUseCase: GetSimilarMoviesUseCase!
            var movieRepositoryMock: MovieRepositoryMock!

            beforeEach {
                movieRepositoryMock = MovieRepositoryMock()
                getSimilarMoviesUseCase = GetSimilarMoviesUseCase(movieRepository: movieRepositoryMock)
            }

            context("movie repository gets similar movies -> error") {
                it("returns error") {
                    movieRepositoryMock.settings.shouldReturnError = true

                    waitUntil { done in
                        getSimilarMoviesUseCase.execute(with: id) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.getSimilarMovies) == true
                            expect(movieRepositoryMock.arguments.id) == id
                            done()
                        }
                    }
                }
            }

            context("movie repository gets similar movies -> movies") {
                it("returns movies") {
                    waitUntil { done in
                        getSimilarMoviesUseCase.execute(with: id) { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.getSimilarMovies) == true
                            expect(movieRepositoryMock.arguments.id) == id
                            done()
                        }
                    }
                }
            }
        }
    }
}
