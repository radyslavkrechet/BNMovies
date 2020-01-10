//
//  MovieRepositorySpec.swift
//  DataTests
//
//  Created by Radyslav Krechet on 28.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain

@testable import Data

// swiftlint:disable:next type_body_length
class MovieRepositorySpec: QuickSpec {
    // swiftlint:disable:next function_body_length cyclomatic_complexity
    override func spec() {
        var movieRepository: MovieRepository!
        var movieAPIMock: MovieAPIMock!
        var movieDAOMock: MovieDAOMock!

        beforeEach {
            movieAPIMock = MovieAPIMock()
            movieDAOMock = MovieDAOMock()
            movieRepository = MovieRepository(movieAPI: movieAPIMock, movieDAO: movieDAOMock)
        }

        describe("get movies") {
            let category = Movie.Category.popular
            let page = 0

            context("movie api gets movies -> error") {
                it("returns error") {
                    movieAPIMock.settings.shouldReturnError = true

                    movieRepository.getMovies(with: category, page: page) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(movieAPIMock.calls.getMovies) == true
                        expect(movieAPIMock.arguments.category) == category
                        expect(movieAPIMock.arguments.page) == page
                    }
                }
            }

            context("movie api gets movies -> movies") {
                it("returns movies") {
                    movieRepository.getMovies(with: category, page: page) { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(movieAPIMock.calls.getMovies) == true
                        expect(movieAPIMock.arguments.category) == category
                        expect(movieAPIMock.arguments.page) == page
                    }
                }
            }
        }

        describe("get favourites") {
            context("movie dao gets favourites -> error") {
                it("returns error") {
                    movieDAOMock.settings.shouldReturnError = true

                    movieRepository.getFavourites { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(movieDAOMock.calls.getFavourites) == true
                    }
                }
            }

            context("movie dao gets favourites -> movies") {
                it("returns movies") {
                    movieRepository.getFavourites { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(movieDAOMock.calls.getFavourites) == true
                    }
                }
            }
        }

        describe("get movie") {
            let id = "id"

            context("movie dao gets movie -> error") {
                it("returns error") {
                    movieDAOMock.settings.shouldReturnError = true

                    movieRepository.getMovie(with: id) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(movieDAOMock.calls.getMovie) == true
                        expect(movieDAOMock.arguments.id) == id
                    }
                }
            }

            context("movie dao gets movie -> nil") {
                context("movie api gets movie -> error") {
                    it("returns error") {
                        movieDAOMock.settings.shouldReturnNil = true
                        movieAPIMock.settings.shouldReturnError = true

                        movieRepository.getMovie(with: id) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(movieDAOMock.calls.getMovie) == true
                            expect(movieDAOMock.arguments.id) == id
                            expect(movieAPIMock.calls.getMovie) == true
                            expect(movieAPIMock.arguments.id) == id
                        }
                    }
                }

                context("movie api gets movie -> movie") {
                    context("movie dao sets movie -> error") {
                        it("returns error") {
                            movieDAOMock.settings.shouldReturnError = true
                            movieDAOMock.settings.errorIndex = 1
                            movieDAOMock.settings.shouldReturnNil = true

                            movieRepository.getMovie(with: id) { result in
                                guard case .failure = result else {
                                    fail()
                                    return
                                }

                                expect(movieDAOMock.calls.getMovie) == true
                                expect(movieDAOMock.arguments.id) == id
                                expect(movieAPIMock.calls.getMovie) == true
                                expect(movieAPIMock.arguments.id) == id
                                expect(movieDAOMock.calls.set) == true
                            }
                        }
                    }

                    context("movie dao sets movie -> movie") {
                        it("returns movie") {
                            movieDAOMock.settings.shouldReturnNil = true

                            movieRepository.getMovie(with: id) { result in
                                guard case .success = result else {
                                    fail()
                                    return
                                }

                                expect(movieDAOMock.calls.getMovie) == true
                                expect(movieDAOMock.arguments.id) == id
                                expect(movieAPIMock.calls.getMovie) == true
                                expect(movieAPIMock.arguments.id) == id
                                expect(movieDAOMock.calls.set) == true
                            }
                        }
                    }
                }
            }

            context("movie dao gets movie -> movie") {
                context("movie api gets movie -> error") {
                    it("returns movie, returns error") {
                        movieAPIMock.settings.shouldReturnError = true

                        waitUntil { done in
                            var returnIndex = 0
                            movieRepository.getMovie(with: id) { result in
                                if returnIndex == 0 {
                                    guard case .success = result else {
                                        fail()
                                        return
                                    }

                                    expect(movieDAOMock.calls.getMovie) == true
                                    expect(movieDAOMock.arguments.id) == id
                                    returnIndex += 1
                                } else {
                                    guard case .failure = result else {
                                        fail()
                                        return
                                    }

                                    expect(movieAPIMock.calls.getMovie) == true
                                    expect(movieAPIMock.arguments.id) == id
                                    done()
                                }
                            }
                        }
                    }
                }

                context("movie api gets movie -> movie") {
                    context("movie dao sets movie -> error") {
                        it("returns movie, returns error") {
                            movieDAOMock.settings.shouldReturnError = true
                            movieDAOMock.settings.errorIndex = 1

                            waitUntil { done in
                                var returnIndex = 0
                                movieRepository.getMovie(with: id) { result in
                                    if returnIndex == 0 {
                                        guard case .success = result else {
                                            fail()
                                            return
                                        }

                                        expect(movieDAOMock.calls.getMovie) == true
                                        expect(movieDAOMock.arguments.id) == id
                                        returnIndex += 1
                                    } else {
                                        guard case .failure = result else {
                                            fail()
                                            return
                                        }

                                        expect(movieAPIMock.calls.getMovie) == true
                                        expect(movieAPIMock.arguments.id) == id
                                        expect(movieDAOMock.calls.set) == true
                                        done()
                                    }
                                }
                            }
                        }
                    }

                    context("movie dao sets movie -> movie") {
                        it("returns movie, returns movie") {
                            movieDAOMock.settings.movie = Mock.movie(isFavourite: true)
                            movieAPIMock.settings.movie = Mock.movie(isFavourite: false)

                            waitUntil { done in
                                var returnIndex = 0
                                movieRepository.getMovie(with: id) { result in
                                    if returnIndex == 0 {
                                        guard case .success = result else {
                                            fail()
                                            return
                                        }

                                        expect(movieDAOMock.calls.getMovie) == true
                                        expect(movieDAOMock.arguments.id) == id
                                        returnIndex += 1
                                    } else {
                                        guard case .success = result else {
                                            fail()
                                            return
                                        }

                                        expect(movieAPIMock.calls.getMovie) == true
                                        expect(movieAPIMock.arguments.id) == id
                                        expect(movieDAOMock.calls.set) == true
                                        expect(movieDAOMock.arguments.movie!.isFavourite) == true
                                        done()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        describe("get similar movies") {
            let id = "id"

            context("movie api gets similar movies -> error") {
                it("returns error") {
                    movieAPIMock.settings.shouldReturnError = true

                    movieRepository.getSimilarMovies(id) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(movieAPIMock.calls.getSimilarMovies) == true
                        expect(movieAPIMock.arguments.id) == id
                    }
                }
            }

            context("movie api gets similar movies -> movies") {
                it("returns movies") {
                    movieRepository.getSimilarMovies(id) { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(movieAPIMock.calls.getSimilarMovies) == true
                        expect(movieAPIMock.arguments.id) == id
                    }
                }
            }
        }

        describe("add to favourites") {
            let movie = Mock.movie(isFavourite: false)

            context("movie dao adds to favourites -> error") {
                it("returns error") {
                    movieDAOMock.settings.shouldReturnError = true

                    movieRepository.addToFavourites(movie) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(movieDAOMock.calls.set) == true
                        expect(movieDAOMock.arguments.movie!.isFavourite) == true
                    }
                }
            }

            context("movie dao adds to favourites -> movie") {
                it("returns movie") {
                    movieRepository.addToFavourites(movie) { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(movieDAOMock.calls.set) == true
                        expect(movieDAOMock.arguments.movie!.isFavourite) == true
                    }
                }
            }
        }

        describe("delete from favourites") {
            let movie = Mock.movie(isFavourite: true)

            context("movie dao deletes from favourites -> error") {
                it("returns error") {
                    movieDAOMock.settings.shouldReturnError = true

                    movieRepository.deleteFromFavourites(movie) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(movieDAOMock.calls.set) == true
                        expect(movieDAOMock.arguments.movie!.isFavourite) == false
                    }
                }
            }

            context("movie dao deletes from favourites -> movie") {
                it("returns movie") {
                    movieRepository.deleteFromFavourites(movie) { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(movieDAOMock.calls.set) == true
                        expect(movieDAOMock.arguments.movie!.isFavourite) == false
                    }
                }
            }
        }
    }
}
