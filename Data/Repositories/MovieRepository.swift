//
//  MovieRepository.swift
//  Data
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

class MovieRepository: MovieRepositoryProtocol {
    private let movieAPI: MovieAPIProtocol
    private let movieDAO: MovieDAOProtocol

    init(movieAPI: MovieAPIProtocol, movieDAO: MovieDAOProtocol) {
        self.movieAPI = movieAPI
        self.movieDAO = movieDAO
    }

    func getMovies(with category: Movie.Category, page: Int, handler: @escaping Handler<[Movie]>) {
        movieAPI.getMovies(with: category, page: page, handler: handler)
    }

    func getFavourites(handler: @escaping Handler<[Movie]>) {
        movieDAO.getFavourites(handler: handler)
    }

    func getMovie(with id: String, handler: @escaping Handler<Movie>) {
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
                        let isFavourite = daoMovie?.isFavourite ?? apiMovie.isFavourite
                        let movie = apiMovie.copy(isFavourite: isFavourite)
                        self.movieDAO.set(movie, handler: handler)
                    }
                }
            }
        }
    }

    func getSimilarMovies(_ id: String, handler: @escaping Handler<[Movie]>) {
        movieAPI.getSimilarMovies(id, handler: handler)
    }

    func addToFavourites(_ movie: Movie, handler: @escaping Handler<Movie>) {
        let movie = movie.copy(isFavourite: true)
        movieDAO.set(movie, handler: handler)
    }

    func deleteFromFavourites(_ movie: Movie, handler: @escaping Handler<Movie>) {
        let movie = movie.copy(isFavourite: false)
        movieDAO.set(movie, handler: handler)
    }
}
