//
//  HomeViewMock.swift
//  BoilerplateTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Boilerplate

class HomeViewMock: HomeViewProtocol {
    struct Calls {
        var populateWithState = false
        var populateWithMovies = false
    }

    struct Arguments {
        var states = [ContentState]()
    }

    var calls = Calls()
    var arguments = Arguments()

    func populate(with state: ContentState) {
        calls.populateWithState = true
        arguments.states.append(state)
    }

    func populate(with movies: [Movie]) {
        calls.populateWithMovies = true
    }
}
