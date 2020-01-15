//
//  MovieRepositoryProtocol.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol MovieRepositoryProtocol: class {
    func getChart(_ chart: Movie.Chart, page: Int, handler: @escaping Handler<[Movie]>)
    func getCollection(_ collection: Movie.Collection, handler: @escaping Handler<[Movie]>)
    func getMovie(with id: String, handler: @escaping Handler<Movie>)
    func getSimilarMovies(_ id: String, handler: @escaping Handler<[Movie]>)
    func toggleMovieCollection(_ movie: Movie, collection: Movie.Collection, handler: @escaping Handler<Movie>)
}
