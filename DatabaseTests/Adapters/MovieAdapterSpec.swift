//
//  MovieAdapterSpec.swift
//  DatabaseTests
//
//  Created by Radyslav Krechet on 04.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain
import CoreStore

@testable import Database

class MovieAdapterSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var movieAdapter: MovieAdapter!
        var genreAdapter: GenreAdapterMock!

        beforeEach {
            DatabaseService.setup(isInMemoryStore: true)
            genreAdapter = GenreAdapterMock()
            movieAdapter = MovieAdapter(genreAdapter: genreAdapter)
        }

        describe("from storage") {
            it("returns movie") {
                expect {
                    return try CoreStoreDefaults.dataStack.perform(synchronous: { transaction -> Movie in
                        let genre = transaction.create(Into<GenreEntity>())
                        let entity = transaction.create(Into<MovieEntity>())
                        entity.id.value = "id"
                        entity.title.value = "title"
                        entity.overview.value = "overview"
                        entity.posterSource.value = "posterSource"
                        entity.backdropSource.value = "backdropSource"
                        entity.runtime.value = 0
                        entity.releaseDate.value = Date()
                        entity.userScore.value = 1
                        entity.genres.value = [genre]
                        entity.isInFavourites.value = false
                        entity.isInWatchlist.value = false

                        let object = movieAdapter.fromStorage(entity)

                        expect(object.id) == entity.id.value
                        expect(object.title) == entity.title.value
                        expect(object.overview) == entity.overview.value
                        expect(object.posterSource) == entity.posterSource.value
                        expect(object.backdropSource) == entity.backdropSource.value
                        expect(object.runtime) == entity.runtime.value
                        expect(object.releaseDate) == entity.releaseDate.value
                        expect(object.userScore) == entity.userScore.value
                        expect(object.genres.count) == entity.genres.value.count
                        expect(object.isInFavourites) == entity.isInFavourites.value
                        expect(object.isInWatchlist) == entity.isInWatchlist.value

                        expect(genreAdapter.calls.fromStorage) == true

                        return object
                    })
                }.toNot(throwError())
            }
        }

        describe("to storage") {
            it("returns movie entity") {
                let object = Movie(id: "id",
                    title: "title",
                    overview: "overview",
                    posterSource: "posterSource",
                    backdropSource: "backdropSource",
                    runtime: 0,
                    releaseDate: Date(),
                    userScore: 1,
                    genres: [],
                    isInFavourites: false,
                    isInWatchlist: false)

                expect {
                    return try CoreStoreDefaults.dataStack.perform(synchronous: { transaction -> MovieEntity in
                        let genre = transaction.create(Into<GenreEntity>())
                        let relationship = [genre]
                        var entity = transaction.create(Into<MovieEntity>())
                        entity = movieAdapter.toStorage(object, entity, relationship)

                        expect(entity.id.value) == object.id
                        expect(entity.title.value) == object.title
                        expect(entity.overview.value) == object.overview
                        expect(entity.posterSource.value) == object.posterSource
                        expect(entity.backdropSource.value) == object.backdropSource
                        expect(entity.runtime.value) == object.runtime
                        expect(entity.releaseDate.value) == object.releaseDate
                        expect(entity.userScore.value) == object.userScore
                        expect(entity.genres.value) == relationship
                        expect(entity.isInFavourites.value) == object.isInFavourites
                        expect(entity.isInWatchlist.value) == object.isInWatchlist

                        return entity
                    })
                }.toNot(throwError())
            }
        }
    }
}
