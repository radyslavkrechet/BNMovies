//
//  MovieAdapterMock.swift
//  NetTests
//
//  Created by Radyslav Krechet on 02.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Net

class MovieAdapterMock: MovieAdapterProtocol {
    struct Calls {
        var toObjects = false
        var toObject = false
    }

    var calls = Calls()

    func toObjects(_ response: GetMoviesResponse) -> [Movie] {
        calls.toObjects = true
        return []
    }

    func toObject(_ response: GetMovieResponse) -> Movie {
        calls.toObject = true
        return Mock.movie
    }
}
