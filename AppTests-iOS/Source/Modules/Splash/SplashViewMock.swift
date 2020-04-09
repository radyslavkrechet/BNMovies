//
//  SplashViewMock.swift
//  MoviesTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Core

@testable import Movies

class SplashViewMock: SplashViewProtocol {
    struct Calls {
        var populate = false
        var navigate = false
    }

    struct Arguments {
        var states = [ContentState]()
        var isSignedIn: Bool?
    }

    var calls = Calls()
    var arguments = Arguments()

    func populate(with state: ContentState) {
        calls.populate = true
        arguments.states.append(state)
    }

    func navigate(_ isSignedIn: Bool) {
        calls.navigate = true
        arguments.isSignedIn = isSignedIn
    }
}
