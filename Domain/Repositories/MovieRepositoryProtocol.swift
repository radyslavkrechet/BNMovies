//
//  MovieRepositoryProtocol.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol MovieRepositoryProtocol: class {
    func getMovies(with category: Movie.Category, page: Int, handler: @escaping Handler<[Movie]>)
    func getFavourites(handler: @escaping Handler<[Movie]>)
    func getMovie(with id: String, handler: @escaping Handler<Movie>)
    func getSimilarMovies(_ id: String, handler: @escaping Handler<[Movie]>)
    func addToFavourites(_ movie: Movie, handler: @escaping Handler<Movie>)
    func deleteFromFavourites(_ movie: Movie, handler: @escaping Handler<Movie>)
}
