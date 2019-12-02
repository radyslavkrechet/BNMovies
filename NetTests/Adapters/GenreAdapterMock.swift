//
//  GenreAdapterMock.swift
//  NetTests
//
//  Created by Radyslav Krechet on 29.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Net

private enum Mock {
    static var genre: Genre {
        Genre(id: "id", name: "name")
    }
}

class GenreAdapterMock: GenreAdapterProtocol {
    struct Calls {
        var toEntity = false
    }

    var calls = Calls()

    func toEntity(_ response: GenreResponse) -> Genre {
        calls.toEntity = true
        return Mock.genre
    }
}
