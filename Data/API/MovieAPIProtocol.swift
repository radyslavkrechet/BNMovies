//
//  MovieAPIProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain

public protocol MovieAPIProtocol {
    func getMovies(with page: Int, handler: @escaping Handler<[Movie]>)
    func getMovie(with id: String, handler: @escaping Handler<Movie>)
    func getSimilarMovies(_ id: String, handler: @escaping Handler<[Movie]>)
}
