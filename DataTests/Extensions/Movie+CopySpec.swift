//
//  Movie+CopySpec.swift
//  DataTests
//
//  Created by Radyslav Krechet on 28.11.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain

@testable import Data

class MovieCopySpec: QuickSpec {
    override func spec() {
        describe("copy") {
            context("without argument") {
                it("returns copy") {
                    let movie = Mock.movie
                    let copy = movie.copy()

                    expect(copy) == movie
                }
            }

            context("with argument") {
                it("returns copy with modified property") {
                    let movie = Mock.movie(isInFavourites: false, isInWatchlist: false)
                    let copy = movie.copy(isInFavourites: true, isInWatchlist: true)

                    expect(copy.id) == movie.id
                    expect(copy.title) == movie.title
                    expect(copy.overview) == movie.overview
                    expect(copy.posterSource) == movie.posterSource
                    expect(copy.backdropSource) == movie.backdropSource
                    expect(copy.runtime) == movie.runtime
                    expect(copy.releaseDate) == movie.releaseDate
                    expect(copy.userScore) == movie.userScore
                    expect(copy.genres) == movie.genres
                    expect(copy.isInFavourites) == true
                    expect(copy.isInWatchlist) == true
                }
            }
        }
    }
}
