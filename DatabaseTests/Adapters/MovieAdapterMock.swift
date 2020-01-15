//
//  MovieAdapterMock.swift
//  DatabaseTests
//
//  Created by Radyslav Krechet on 04.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Database

class MovieAdapterMock: MovieAdapterProtocol {
    struct Calls {
        var fromStorage = false
        var toStorage = false
    }

    var calls = Calls()

    func fromStorage(_ entity: MovieEntity) -> Movie {
        calls.fromStorage = true
        return Mock.movieObject
    }

    func toStorage(_ object: Movie, _ entity: MovieEntity, _ relationship: [GenreEntity]) -> MovieEntity {
        calls.toStorage = true
        return Mock.movieEntity
    }
}
