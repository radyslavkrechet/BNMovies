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

        describe("to objects") {
            it("returns movies") {
                let response = Mock.getMoviesResponse
                let movies = movieAdapter.toObjects(response)

                expect(movies.count) == response.results.count
            }
        }

        describe("to object") {
            context("response has no optional values") {
                it("returns movie without optional values") {
                    let response = Mock.getMovieResponse(hasOptionalValues: false)
                    let movie = movieAdapter.toObject(response)

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

                    expect(genreAdapterMock.calls.toObject) == false
                }
            }

            context("response has optional values") {
                it("returns movie with optional values") {
                    let response = Mock.getMovieResponse(hasOptionalValues: true)
                    let movie = movieAdapter.toObject(response)

                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    let releaseDate = formatter.date(from: response.releaseDate!)

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

                    expect(genreAdapterMock.calls.toObject) == true
                }
            }
        }
    }
}
