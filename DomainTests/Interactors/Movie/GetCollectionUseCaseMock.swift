//
//  GetCollectionUseCaseMock.swift
//  MoviesTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

@testable import Domain

class GetCollectionUseCaseMock: GetCollectionUseCaseProtocol {
    struct Settings {
        var shouldReturnError = false
        var shouldReturnEmpty = false
    }

    struct Calls {
        var execute = false
    }

    struct Arguments {
        var collection: Movie.Collection?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    func execute(with collection: Movie.Collection, handler: @escaping Handler<[Movie]>) {
        calls.execute = true
        arguments.collection = collection
        handler(settings.shouldReturnError
            ? .failure(Mock.Error.force)
            : .success(settings.shouldReturnEmpty ? [] : [Mock.movie]))
    }
}
