//
//  MovieAdapter.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain

enum MovieAdapter {
    static func fromStorage(_ entity: MovieEntity) -> Movie {
        return Movie(id: entity.id.value,
                     title: entity.title.value,
                     overview: entity.overview.value,
                     posterSource: entity.posterSource.value,
                     backdropSource: entity.backdropSource.value,
                     runtime: entity.runtime.value,
                     releaseDate: entity.releaseDate.value,
                     userScore: entity.userScore.value,
                     genres: entity.genres.map { GenreAdapter.fromStorage($0) },
                     isFavourite: entity.isFavourite.value)
    }

    static func toStorage(_ movie: Movie, _ genreEntities: [GenreEntity], _ entity: MovieEntity) {
        entity.id.value = movie.id
        entity.title.value = movie.title
        entity.overview.value = movie.overview
        entity.posterSource.value = movie.posterSource
        entity.backdropSource.value = movie.backdropSource
        entity.runtime.value = movie.runtime
        entity.releaseDate.value = movie.releaseDate
        entity.userScore.value = movie.userScore
        entity.genres.value = genreEntities
        entity.isFavourite.value = movie.isFavourite
    }
}
