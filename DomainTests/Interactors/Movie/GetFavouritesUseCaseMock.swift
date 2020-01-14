//
//  GetFavouritesUseCaseMock.swift
//  MoviesTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

@testable import Domain

class GetFavouritesUseCaseMock: GetFavouritesUseCaseProtocol {
    struct Settings {
        var shouldReturnError = false
        var shouldReturnEmpty = false
    }

    struct Calls {
        var execute = false
    }

    var settings = Settings()
    var calls = Calls()

    func execute(_ handler: @escaping Handler<[Movie]>) {
        calls.execute = true
        handler(settings.shouldReturnError
            ? .failure(Mock.Error.force)
            : .success(settings.shouldReturnEmpty ? [] : [Mock.movie]))
    }
}
