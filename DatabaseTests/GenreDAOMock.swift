//
//  GenreDAOMock.swift
//  DatabaseTests
//
//  Created by Radyslav Krechet on 05.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Database

class GenreDAOMock: GenreDAOProtocol {
    struct Settings {
        var shouldReturnError = false
    }

    struct Calls {
        var set = false
    }

    struct Arguments {
        var genres: [Genre]?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    func set(_ genres: [Genre], handler: @escaping Handler<[GenreEntity]>) {
        calls.set = true
        arguments.genres = genres
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success([]))
    }
}
