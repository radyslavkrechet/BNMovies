//
//  MovieDAO.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import Data
import CoreStore

class MovieDAO: MovieDAOProtocol {
    func set(_ movie: Movie, handler: @escaping Handler<Movie>) {
        CoreStore.perform(asynchronous: { transaction in
            let genreEntities = try movie.genres.map { genre -> GenreEntity in
                let builder = From<GenreEntity>().where(\.id == genre.id)
                let into = Into<GenreEntity>()
                let entity = try transaction.fetchOne(builder) ?? transaction.create(into)
                GenreAdapter.toStorage(genre, entity)
                return entity
            }

            let builder = From<MovieEntity>().where(\.id == movie.id)
            let into = Into<MovieEntity>()
            let entity = try transaction.fetchOne(builder) ?? transaction.create(into)
            MovieAdapter.toStorage(movie, genreEntities, entity)
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success: handler(.success(movie))
            }
        })
    }

    func getFavourites(handler: @escaping Handler<[Movie]>) {
        CoreStore.perform(asynchronous: { transaction -> [Movie] in
            let builder = From<MovieEntity>().where(\.isFavourite == true)
            let entities = try transaction.fetchAll(builder)
            return entities.map { MovieAdapter.fromStorage($0) }.reversed()
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let movies): handler(.success(movies))
            }
        })
    }

    func getMovie(with id: String, handler: @escaping Handler<Movie?>) {
        CoreStore.perform(asynchronous: { transaction -> Movie? in
            let builder = From<MovieEntity>().where(\.id == id)
            let entity = try transaction.fetchOne(builder)

            var movie: Movie?
            if let entity = entity {
                movie = MovieAdapter.fromStorage(entity)
            }
            return movie
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let movie): handler(.success(movie))
            }
        })
    }
}
