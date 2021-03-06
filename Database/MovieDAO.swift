//
//  MovieDAO.swift
//  Database
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain
import Data

class MovieDAO<DatabaseManager: DatabaseManagerProtocol>: MovieDAOProtocol
    where DatabaseManager.Object == Movie, DatabaseManager.Entity == MovieEntity {

    private let databaseManager: DatabaseManager
    private let movieAdapter: MovieAdapterProtocol
    private let genreDAO: GenreDAOProtocol

    init(databaseManager: DatabaseManager, movieAdapter: MovieAdapterProtocol, genreDAO: GenreDAOProtocol) {
        self.databaseManager = databaseManager
        self.movieAdapter = movieAdapter
        self.genreDAO = genreDAO
    }

    func set(_ movie: Movie, handler: @escaping Handler<Movie>) {
        genreDAO.set(movie.genres) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let genreEntities):
                let adapter: (Movie, MovieEntity, [GenreEntity]) -> MovieEntity = { object, entity, relationship in
                    return self.movieAdapter.toStorage(object, entity, relationship)
                }

                self.databaseManager.set(object: movie, relationship: genreEntities, adapter: adapter) { result in
                    switch result {
                    case .failure(let error): handler(.failure(error))
                    case .success: handler(.success(movie))
                    }
                }
            }
        }
    }

    func getMovies(_ collection: Movie.Collection, handler: @escaping Handler<[Movie]>) {
        let predicateField = collection == .favourites ? "isInFavourites" : "isInWatchlist"

        let adapter: (MovieEntity) -> Movie = { entity in
            return self.movieAdapter.fromStorage(entity)
        }

        databaseManager.getAll(predicate: "\(predicateField) == true", adapter: adapter, handler: handler)
    }

    func getMovie(with id: String, handler: @escaping Handler<Movie?>) {
        let adapter: (MovieEntity) -> Movie = { entity in
            return self.movieAdapter.fromStorage(entity)
        }

        databaseManager.getFirst(predicate: "id == \(id)", adapter: adapter, handler: handler)
    }
}
