//
//  GetCollectionUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol GetCollectionUseCaseProtocol {
    func execute(with collection: Movie.Collection, handler: @escaping Handler<[Movie]>)
}

public class GetCollectionUseCase: GetCollectionUseCaseProtocol, Executable {
    lazy var work = { [weak self] in
        guard let self = self else { return }
        self.movieRepository.getCollection(self.collection, handler: self.handler)
    }

    @AsyncOnMain var handler: Handler<[Movie]>!

    private let movieRepository: MovieRepositoryProtocol
    private var collection: Movie.Collection!

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func execute(with collection: Movie.Collection, handler: @escaping Handler<[Movie]>) {
        self.collection = collection
        self.handler = handler
        execute()
    }
}
