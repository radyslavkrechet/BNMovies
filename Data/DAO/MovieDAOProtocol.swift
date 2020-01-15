//
//  MovieDAOProtocol.swift
//  Data
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

public protocol MovieDAOProtocol: class {
    func set(_ movie: Movie, handler: @escaping Handler<Movie>)
    func getMovies(_ collection: Movie.Collection, handler: @escaping Handler<[Movie]>)
    func getMovie(with id: String, handler: @escaping Handler<Movie?>)
}
