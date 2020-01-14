//
//  GetMoviesUseCaseMock.swift
//  BoilerplateTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

@testable import Domain

class GetMoviesUseCaseMock: GetMoviesUseCaseProtocol {
    struct Settings {
        var shouldReturnError = false
        var shouldReturnEmpty = false
    }

    struct Calls {
        var execute = false
    }

    struct Arguments {
        var chart: Movie.Chart?
        var page: Int?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    func execute(with chart: Movie.Chart, page: Int, handler: @escaping Handler<[Movie]>) {
        calls.execute = true
        arguments.chart = chart
        arguments.page = page
        handler(settings.shouldReturnError
            ? .failure(Mock.Error.force)
            : .success(settings.shouldReturnEmpty ? [] : [Mock.movie]))
    }
}
