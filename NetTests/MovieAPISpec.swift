//
//  MovieAPISpec.swift
//  NetTests
//
//  Created by Radyslav Krechet on 02.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Net

class MovieAPISpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var networkManagerMock: NetworkManagerMock!
        var coderServiceMock: CoderServiceMock!
        var movieAdapterMock: MovieAdapterMock!
        var movieAPI: MovieAPI!

        beforeEach {
            networkManagerMock = NetworkManagerMock()
            coderServiceMock = CoderServiceMock()
            movieAdapterMock = MovieAdapterMock()
            movieAPI = MovieAPI(networkManager: networkManagerMock,
                                coderService: coderServiceMock,
                                movieAdapter: movieAdapterMock)
        }

        describe("get movies") {
            let page = 0

            context("network manager executes request -> error") {
                it("returns error") {
                    networkManagerMock.settings.shouldReturnError = true

                    movieAPI.getMovies(with: page) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(networkManagerMock.calls.execute) == true
                    }
                }
            }

            context("network manager executes request -> json") {
                beforeEach {
                    coderServiceMock.settings.response = GetMoviesResponse(results: [])
                }

                context("json is invalid") {
                    it("returns error") {
                        coderServiceMock.settings.shouldReturnError = true

                        movieAPI.getMovies(with: page) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(networkManagerMock.calls.execute) == true
                            expect(coderServiceMock.calls.decode) == true
                        }
                    }
                }

                context("json is valid") {
                    it("returns movies") {
                        movieAPI.getMovies(with: page) { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(networkManagerMock.calls.execute) == true
                            expect(coderServiceMock.calls.decode) == true
                            expect(movieAdapterMock.calls.toEntities) == true
                        }
                    }
                }
            }
        }

        describe("get movie") {
            let id = "id"
            context("network manager executes request -> error") {
                it("returns error") {
                    networkManagerMock.settings.shouldReturnError = true

                    movieAPI.getMovie(with: id) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(networkManagerMock.calls.execute) == true
                    }
                }
            }

            context("network manager executes request -> json") {
                beforeEach {
                    let movie = GetMovieResponse(id: 0,
                                                 title: "title",
                                                 overview: "overview",
                                                 posterPath: "posterPath",
                                                 backdropPath: "backdropPath",
                                                 runtime: 0,
                                                 releaseDate: "releaseDate",
                                                 voteAverage: 0,
                                                 genres: [])

                    coderServiceMock.settings.response = movie
                }

                context("json is invalid") {
                    it("returns error") {
                        coderServiceMock.settings.shouldReturnError = true

                        movieAPI.getMovie(with: id) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(networkManagerMock.calls.execute) == true
                            expect(coderServiceMock.calls.decode) == true
                        }
                    }
                }

                context("json is valid") {
                    it("returns movie") {
                        movieAPI.getMovie(with: id) { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(networkManagerMock.calls.execute) == true
                            expect(coderServiceMock.calls.decode) == true
                            expect(movieAdapterMock.calls.toEntity) == true
                        }
                    }
                }
            }
        }

        describe("get similar movies") {
            let id = "id"
            context("network manager executes request -> error") {
                it("returns error") {
                    networkManagerMock.settings.shouldReturnError = true

                    movieAPI.getSimilarMovies(id) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(networkManagerMock.calls.execute) == true
                    }
                }
            }

            context("network manager executes request -> json") {
                beforeEach {
                    coderServiceMock.settings.response = GetMoviesResponse(results: [])
                }

                context("json is invalid") {
                    it("returns error") {
                        coderServiceMock.settings.shouldReturnError = true

                        movieAPI.getSimilarMovies(id) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(networkManagerMock.calls.execute) == true
                            expect(coderServiceMock.calls.decode) == true
                        }
                    }
                }

                context("json is valid") {
                    it("returns similar movies") {
                        movieAPI.getSimilarMovies(id) { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(networkManagerMock.calls.execute) == true
                            expect(coderServiceMock.calls.decode) == true
                            expect(movieAdapterMock.calls.toEntities) == true
                        }
                    }
                }
            }
        }
    }
}
