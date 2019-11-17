//
//  MovieDAOProtocol.swift
//  Data
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

public protocol MovieDAOProtocol {
    func set(_ movie: Movie, handler: @escaping Handler<Movie>)
    func getFavourites(handler: @escaping Handler<[Movie]>)
    func getMovie(with id: String, handler: @escaping Handler<Movie?>)
}
