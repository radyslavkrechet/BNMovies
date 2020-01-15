//
//  GenreAdapterMock.swift
//  DatabaseTests
//
//  Created by Radyslav Krechet on 04.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Database

class GenreAdapterMock: GenreAdapterProtocol {
    struct Calls {
        var fromStorage = false
        var toStorage = false
    }

    var calls = Calls()

    func fromStorage(_ entity: GenreEntity) -> Genre {
        calls.fromStorage = true
        return Mock.genreObject
    }

    func toStorage(_ object: Genre, _ entity: GenreEntity) -> GenreEntity {
        calls.toStorage = true
        return Mock.genreEntity
    }
}
