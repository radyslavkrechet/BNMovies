//
//  GenreAdapterMock.swift
//  NetTests
//
//  Created by Radyslav Krechet on 29.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Net

class GenreAdapterMock: GenreAdapterProtocol {
    struct Calls {
        var toObject = false
    }

    var calls = Calls()

    func toObject(_ response: GenreResponse) -> Genre {
        calls.toObject = true
        return Mock.genre
    }
}
