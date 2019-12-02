//
//  MovieAPI.swift
//  Net
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Data
import Foundation

class MovieAPI: MovieAPIProtocol {
    private let networkManager: NetworkManagerProtocol
    private let coderService: CoderServiceProtocol
    private let movieAdapter: MovieAdapterProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager(),
         coderService: CoderServiceProtocol = CoderService(),
         movieAdapter: MovieAdapterProtocol = MovieAdapter()) {

        self.networkManager = networkManager
        self.coderService = coderService
        self.movieAdapter = movieAdapter
    }

    func getMovies(with page: Int, handler: @escaping Handler<[Movie]>) {
        let request = MovieRouter.getMovies(page: page)
        networkManager.execute(request) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let json):
                do {
                    let response: GetMoviesResponse = try self.coderService.decode(json)
                    let movies = self.movieAdapter.toEntities(response)
                    handler(.success(movies))
                } catch {
                    handler(.failure(error))
                }
            }
        }
    }

    func getMovie(with id: String, handler: @escaping Handler<Movie>) {
        let request = MovieRouter.getMovie(id: id)
        networkManager.execute(request) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let json):
                do {
                    let response: GetMovieResponse = try self.coderService.decode(json)
                    let movie = self.movieAdapter.toEntity(response)
                    handler(.success(movie))
                } catch {
                    handler(.failure(error))
                }
            }
        }
    }

    func getSimilarMovies(_ id: String, handler: @escaping Handler<[Movie]>) {
        let request = MovieRouter.getSimilarMovies(id: id)
        networkManager.execute(request) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let json):
                do {
                    let response: GetMoviesResponse = try self.coderService.decode(json)
                    let movies = self.movieAdapter.toEntities(response)
                    handler(.success(movies))
                } catch {
                    handler(.failure(error))
                }
            }
        }
    }
}
