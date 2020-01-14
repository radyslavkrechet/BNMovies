//
//  MovieDAOSpec.swift
//  DatabaseTests
//
//  Created by Radyslav Krechet on 04.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain

@testable import Database

class MovieDAOSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var movieDAO: MovieDAO<DatabaseManagerMock<Movie, MovieEntity>>!
        var databaseManagerMock: DatabaseManagerMock<Movie, MovieEntity>!
        var movieAdapterMock: MovieAdapterMock!
        var genreDAOMock: GenreDAOMock!

        beforeEach {
            databaseManagerMock = DatabaseManagerMock()
            databaseManagerMock.settings.object = Mock.movieObject
            databaseManagerMock.settings.entity = Mock.movieEntity

            movieAdapterMock = MovieAdapterMock()
            genreDAOMock = GenreDAOMock()

            movieDAO = MovieDAO(databaseManager: databaseManagerMock,
                                movieAdapter: movieAdapterMock,
                                genreDAO: genreDAOMock)
        }

        describe("set movie") {
            let movie = Mock.movieObject

            context("genre dao sets genres -> error") {
                it("returns error") {
                    genreDAOMock.settings.shouldReturnError = true

                    movieDAO.set(movie) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(genreDAOMock.arguments.genres) == movie.genres
                    }
                }
            }

            context("genre dao sets genres -> genre entities") {
                 context("database manager sets movie -> error") {
                    it("returns error") {
                        databaseManagerMock.settings.shouldReturnError = true

                        movieDAO.set(movie) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(genreDAOMock.arguments.genres) == movie.genres
                            expect(databaseManagerMock.calls.setObjectWithRelationship) == true
                            expect(databaseManagerMock.arguments.object) == movie
                            expect(movieAdapterMock.calls.toStorage) == true
                        }
                    }
                }

                context("database manager sets movie -> movie entity") {
                    it("returns movie") {
                        movieDAO.set(movie) { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(genreDAOMock.arguments.genres) == movie.genres
                            expect(databaseManagerMock.calls.setObjectWithRelationship) == true
                            expect(databaseManagerMock.arguments.object) == movie
                            expect(movieAdapterMock.calls.toStorage) == true
                        }
                    }
                }
            }
        }

        describe("get favourites") {
            context("database manager gets favourites -> error") {
                it("returns error") {
                    databaseManagerMock.settings.shouldReturnError = true

                    movieDAO.getFavourites { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.getAll) == true
                        expect(databaseManagerMock.arguments.predicate) == "isFavourite == true"
                    }
                }
            }

            context("database manager gets favourites -> movies") {
                it("returns movies") {
                    movieDAO.getFavourites { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.getAll) == true
                        expect(databaseManagerMock.arguments.predicate) == "isFavourite == true"
                        expect(movieAdapterMock.calls.fromStorage) == true
                    }
                }
            }
        }

        describe("get watchlist") {
            context("database manager gets watchlist -> error") {
                it("returns error") {
                    databaseManagerMock.settings.shouldReturnError = true

                    movieDAO.getWatchlist { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.getAll) == true
                        expect(databaseManagerMock.arguments.predicate) == "isInWatchlist == true"
                    }
                }
            }

            context("database manager gets watchlist -> movies") {
                it("returns movies") {
                    movieDAO.getWatchlist { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.getAll) == true
                        expect(databaseManagerMock.arguments.predicate) == "isInWatchlist == true"
                        expect(movieAdapterMock.calls.fromStorage) == true
                    }
                }
            }
        }

        describe("get movie") {
            let id = "id"

            context("database manager gets movie -> error") {
                it("returns error") {
                    databaseManagerMock.settings.shouldReturnError = true

                    movieDAO.getMovie(with: id) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.getFirstWithPredicate) == true
                        expect(databaseManagerMock.arguments.predicate) == "id == \(id)"
                    }
                }
            }

            context("database manager user movie -> nil") {
                it("returns nil") {
                    databaseManagerMock.settings.shouldReturnNil = true

                    movieDAO.getMovie(with: id) { result in
                        guard case .success(let movie) = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.getFirstWithPredicate) == true
                        expect(databaseManagerMock.arguments.predicate) == "id == \(id)"
                        expect(movie).to(beNil())
                    }
                }
            }

            context("database manager gets movie -> movie") {
                it("returns movie") {
                    movieDAO.getMovie(with: id) { result in
                        guard case .success(let movie) = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.getFirstWithPredicate) == true
                        expect(databaseManagerMock.arguments.predicate) == "id == \(id)"
                        expect(movieAdapterMock.calls.fromStorage) == true
                        expect(movie).toNot(beNil())
                    }
                }
            }
        }
    }
}
