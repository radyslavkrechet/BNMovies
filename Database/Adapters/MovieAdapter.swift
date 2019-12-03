//
//  MovieAdapter.swift
//  Database
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol MovieAdapterProtocol {
    func fromStorage(_ entity: MovieEntity) -> Movie
    func toStorage(_ movie: Movie, _ entity: MovieEntity, _ genreEntities: [GenreEntity]) -> MovieEntity
}

struct MovieAdapter: MovieAdapterProtocol {
    private let genreAdapter: GenreAdapterProtocol

    init(genreAdapter: GenreAdapterProtocol = GenreAdapter()) {
        self.genreAdapter = genreAdapter
    }

    func fromStorage(_ entity: MovieEntity) -> Movie {
        return Movie(id: entity.id.value,
                     title: entity.title.value,
                     overview: entity.overview.value,
                     posterSource: entity.posterSource.value,
                     backdropSource: entity.backdropSource.value,
                     runtime: entity.runtime.value,
                     releaseDate: entity.releaseDate.value,
                     userScore: entity.userScore.value,
                     genres: entity.genres.map { genreAdapter.fromStorage($0) },
                     isFavourite: entity.isFavourite.value)
    }

    func toStorage(_ object: Movie, _ entity: MovieEntity, _ genreEntities: [GenreEntity]) -> MovieEntity {
        entity.id.value = object.id
        entity.title.value = object.title
        entity.overview.value = object.overview
        entity.posterSource.value = object.posterSource
        entity.backdropSource.value = object.backdropSource
        entity.runtime.value = object.runtime
        entity.releaseDate.value = object.releaseDate
        entity.userScore.value = object.userScore
        entity.genres.value = genreEntities
        entity.isFavourite.value = object.isFavourite
        return entity
    }
}
