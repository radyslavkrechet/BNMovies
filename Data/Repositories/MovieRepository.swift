//
//  MovieRepository.swift
//  Data
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

class MovieRepository: MovieRepositoryProtocol {
    private let movieAPI: MovieAPIProtocol
    private let movieDAO: MovieDAOProtocol?

    init(movieAPI: MovieAPIProtocol, movieDAO: MovieDAOProtocol?) {
        self.movieAPI = movieAPI
        self.movieDAO = movieDAO
    }

    func getChart(_ chart: Movie.Chart, page: Int, handler: @escaping Handler<[Movie]>) {
        movieAPI.getMovies(chart, page: page, handler: handler)
    }

    func getCollection(_ collection: Movie.Collection, handler: @escaping Handler<[Movie]>) {
        guard let movieDAO = movieDAO else {
            handler(.failure(Movie.Error.noPersistence))
            return
        }

        movieDAO.getMovies(collection, handler: handler)
    }

    func getMovie(with id: String, handler: @escaping Handler<Movie>) {
        guard let movieDAO = movieDAO else {
            movieAPI.getMovie(with: id, handler: handler)

            return
        }

        movieDAO.getMovie(with: id) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let daoMovie):
                if let daoMovie = daoMovie {
                    handler(.success(daoMovie))
                }
                self.movieAPI.getMovie(with: id) { result in
                    switch result {
                    case .failure: handler(result)
                    case .success(let apiMovie):
                        let isInFavourites = daoMovie?.isInFavourites ?? apiMovie.isInFavourites
                        let isInWatchlist = daoMovie?.isInWatchlist ?? apiMovie.isInWatchlist
                        let movie = apiMovie.copy(isInFavourites: isInFavourites, isInWatchlist: isInWatchlist)
                        movieDAO.set(movie, handler: handler)
                    }
                }
            }
        }
    }

    func getSimilarMovies(_ id: String, handler: @escaping Handler<[Movie]>) {
        movieAPI.getSimilarMovies(id, handler: handler)
    }

    func toggleMovieCollection(_ movie: Movie, collection: Movie.Collection, handler: @escaping Handler<Movie>) {
        guard let movieDAO = movieDAO else {
            handler(.failure(Movie.Error.noPersistence))
            return
        }

        var clone: Movie!

        switch collection {
        case .favourites: clone = movie.copy(isInFavourites: !movie.isInFavourites)
        case .watchlist: clone = movie.copy(isInWatchlist: !movie.isInWatchlist)
        }

        movieDAO.set(clone, handler: handler)
    }
}
