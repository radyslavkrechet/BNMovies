//
//  MovieAdapterSpec.swift
//  NetTests
//
//  Created by Radyslav Krechet on 29.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain

@testable import Net

class MovieAdapterSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var movieAdapter: MovieAdapter!
        var genreAdapterMock: GenreAdapterMock!

        beforeEach {
            genreAdapterMock = GenreAdapterMock()
            movieAdapter = MovieAdapter(genreAdapter: genreAdapterMock)
        }

        describe("to entities") {
            it("returns movies") {
                let results = [GetMovieResponse(id: 0,
                                                title: "titme",
                                                overview: "overview",
                                                posterPath: nil,
                                                backdropPath: nil,
                                                runtime: nil,
                                                releaseDate: nil,
                                                voteAverage: 7.5,
                                                genres: nil)]

                let response = GetMoviesResponse(results: results)
                let movies = movieAdapter.toEntities(response)

                expect(movies.count) == response.results.count
            }
        }

        describe("to entity") {
            context("response has no optional values") {
                it("returns movie without optional values") {
                    let response = GetMovieResponse(id: 0,
                                                    title: "titme",
                                                    overview: "overview",
                                                    posterPath: nil,
                                                    backdropPath: nil,
                                                    runtime: nil,
                                                    releaseDate: nil,
                                                    voteAverage: 7.5,
                                                    genres: nil)

                    let movie = movieAdapter.toEntity(response)

                    expect(movie.id) == String(response.id)
                    expect(movie.title) == response.title
                    expect(movie.overview) == response.overview
                    expect(movie.posterSource) == ""
                    expect(movie.backdropSource) == ""
                    expect(movie.runtime).to(beNil())
                    expect(movie.releaseDate).to(beNil())
                    expect(movie.userScore) == 75
                    expect(movie.genres).to(beEmpty())
                    expect(movie.isFavourite) == false

                    expect(genreAdapterMock.calls.toEntity) == false
                }
            }

            context("response has optional values") {
                it("returns movie with optional values") {
                    let releaseDateString = "1994-09-27"
                    let response = GetMovieResponse(id: 0,
                                                    title: "titme",
                                                    overview: "overview",
                                                    posterPath: "posterPath",
                                                    backdropPath: "backdropPath",
                                                    runtime: 95,
                                                    releaseDate: releaseDateString,
                                                    voteAverage: 7.5,
                                                    genres: [GenreResponse(id: 0, name: "name")])

                    let movie = movieAdapter.toEntity(response)

                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    let releaseDate = formatter.date(from: releaseDateString)

                    expect(movie.id) == String(response.id)
                    expect(movie.title) == response.title
                    expect(movie.overview) == response.overview
                    expect(movie.posterSource) == "https://image.tmdb.org/t/p/w500posterPath"
                    expect(movie.backdropSource) == "https://image.tmdb.org/t/p/w780backdropPath"
                    expect(movie.runtime) == 95
                    expect(movie.releaseDate) == releaseDate
                    expect(movie.userScore) == 75
                    expect(movie.genres.count) == response.genres!.count
                    expect(movie.isFavourite) == false

                    expect(genreAdapterMock.calls.toEntity) == true
                }
            }
        }
    }
}
