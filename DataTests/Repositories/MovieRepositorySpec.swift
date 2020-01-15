//
//  MovieRepositorySpec.swift
//  DataTests
//
//  Created by Radyslav Krechet on 28.11.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
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

        describe("get chart") {
            let chart = Movie.Chart.popular
            let page = 0

            context("movie api gets movies -> error") {
                it("returns error") {
                    movieAPIMock.settings.shouldReturnError = true

                    movieRepository.getChart(chart, page: page) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(movieAPIMock.calls.getMovies) == true
                        expect(movieAPIMock.arguments.chart) == chart
                        expect(movieAPIMock.arguments.page) == page
                    }
                }
            }

            context("movie api gets movies -> movies") {
                it("returns movies") {
                    movieRepository.getChart(chart, page: page) { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(movieAPIMock.calls.getMovies) == true
                        expect(movieAPIMock.arguments.chart) == chart
                        expect(movieAPIMock.arguments.page) == page
                    }
                }
            }
        }

        describe("get collection") {
            let collection = Movie.Collection.favourites

            context("movie dao gets movies -> error") {
                it("returns error") {
                    movieDAOMock.settings.shouldReturnError = true

                    movieRepository.getCollection(collection) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(movieDAOMock.calls.getMovies) == true
                        expect(movieDAOMock.arguments.collection) == collection
                    }
                }
            }

            context("movie dao gets movies -> movies") {
                it("returns movies") {
                    movieRepository.getCollection(collection) { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(movieDAOMock.calls.getMovies) == true
                        expect(movieDAOMock.arguments.collection) == collection
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
                            movieDAOMock.settings.movie = Mock.movie(isInFavourites: true, isInWatchlist: true)
                            movieAPIMock.settings.movie = Mock.movie(isInFavourites: false, isInWatchlist: false)

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
                                        expect(movieDAOMock.arguments.movie!.isInFavourites) == true
                                        expect(movieDAOMock.arguments.movie!.isInWatchlist) == true
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

        describe("toggle movie collection") {
            let movie = Mock.movie

            context("collection is favourites") {
                let collection = Movie.Collection.favourites

                context("movie dao sets modified clone -> error") {
                    it("returns error") {
                        movieDAOMock.settings.shouldReturnError = true

                        movieRepository.toggleMovieCollection(movie, collection: collection) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(movieDAOMock.calls.set) == true
                            expect(movieDAOMock.arguments.movie!.isInFavourites) == !movie.isInFavourites
                        }
                    }
                }

                context("movie dao sets modified clone -> movie") {
                    it("returns movie") {
                        movieRepository.toggleMovieCollection(movie, collection: collection) { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(movieDAOMock.calls.set) == true
                            expect(movieDAOMock.arguments.movie!.isInFavourites) == !movie.isInFavourites
                        }
                    }
                }
            }

            context("collection is watchlist") {
                let collection = Movie.Collection.watchlist

                context("movie dao sets modified clone -> error") {
                    it("returns error") {
                        movieDAOMock.settings.shouldReturnError = true

                        movieRepository.toggleMovieCollection(movie, collection: collection) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(movieDAOMock.calls.set) == true
                            expect(movieDAOMock.arguments.movie!.isInWatchlist) == !movie.isInWatchlist
                        }
                    }
                }

                context("movie dao sets modified clone -> movie") {
                    it("returns movie") {
                        movieRepository.toggleMovieCollection(movie, collection: collection) { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(movieDAOMock.calls.set) == true
                            expect(movieDAOMock.arguments.movie!.isInWatchlist) == !movie.isInWatchlist
                        }
                    }
                }
            }
        }
    }
}
