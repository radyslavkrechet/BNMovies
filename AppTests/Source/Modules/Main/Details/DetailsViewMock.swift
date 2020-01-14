//
//  DetailsViewMock.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 10.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Boilerplate

class DetailsViewMock: DetailsViewProtocol {
    struct Calls {
        var populateWithState = false
        var populateWithMovie = false
        var presentMarkError = false
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

    func populate(with movie: Movie) {
        calls.populateWithMovie = true
    }

    func presentMarkError(_ error: Error) {
        calls.presentMarkError = true
    }
}