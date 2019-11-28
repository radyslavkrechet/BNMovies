//
//  GetMovieUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 27.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class GetMovieUseCaseSpec: QuickSpec {
    override func spec() {
        describe("execute") {
            let id = "id"
            var getMovieUseCase: GetMovieUseCase!
            var movieRepositoryMock: MovieRepositoryMock!

            beforeEach {
                movieRepositoryMock = MovieRepositoryMock()
                getMovieUseCase = GetMovieUseCase(movieRepository: movieRepositoryMock)
            }

            context("movie repository returns error") {
                it("returns error") {
                    movieRepositoryMock.settings.shouldReturnError = true

                    waitUntil { done in
                        getMovieUseCase.execute(with: id) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.getMovie) == true
                            expect(movieRepositoryMock.arguments.id) == id
                            done()
                        }
                    }
                }
            }

            context("movie repository returns movie") {
                it("returns movie") {
                    waitUntil { done in
                        getMovieUseCase.execute(with: id) { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.getMovie) == true
                            expect(movieRepositoryMock.arguments.id) == id
                            done()
                        }
                    }
                }
            }
        }
    }
}
