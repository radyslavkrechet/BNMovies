//
//  Movie+CopySpec.swift
//  DataTests
//
//  Created by Radyslav Krechet on 28.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
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
                    let movie = self.movie(isFavourite: false)
                    let copy = movie.copy()

                    expect(copy.id) == movie.id
                    expect(copy.title) == movie.title
                    expect(copy.overview) == movie.overview
                    expect(copy.posterSource) == movie.posterSource
                    expect(copy.backdropSource) == movie.backdropSource
                    expect(copy.runtime) == movie.runtime
                    expect(copy.releaseDate) == movie.releaseDate
                    expect(copy.userScore) == movie.userScore
                    expect(copy.genres.count) == movie.genres.count
                    expect(copy.isFavourite) == movie.isFavourite
                }
            }

            context("with argument") {
                it("returns copy with modified property") {
                    let movie = self.movie(isFavourite: false)
                    let copy = movie.copy(isFavourite: true)

                    expect(copy.id) == movie.id
                    expect(copy.title) == movie.title
                    expect(copy.overview) == movie.overview
                    expect(copy.posterSource) == movie.posterSource
                    expect(copy.backdropSource) == movie.backdropSource
                    expect(copy.runtime) == movie.runtime
                    expect(copy.releaseDate) == movie.releaseDate
                    expect(copy.userScore) == movie.userScore
                    expect(copy.genres.count) == movie.genres.count
                    expect(copy.isFavourite) == true
                }
            }
        }
    }

    private func movie(isFavourite: Bool) -> Movie {
        return Movie(id: "id",
                     title: "title",
                     overview: "overview",
                     posterSource: "posterSource",
                     backdropSource: "backdropSource",
                     runtime: 0,
                     releaseDate: Date(),
                     userScore: 0,
                     genres: [Genre(id: "id", name: "name")],
                     isFavourite: isFavourite)
    }
}
