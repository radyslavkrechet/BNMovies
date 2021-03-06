//
//  SignInViewMock.swift
//  MoviesTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

@testable import Movies

class SignInViewMock: SignInViewProtocol {
    struct Calls {
        var populate = false
        var userDidSignIn = false
    }

    struct Arguments {
        var states = [SignInState]()
    }

    var calls = Calls()
    var arguments = Arguments()

    func populate(with state: SignInState) {
        calls.populate = true
        arguments.states.append(state)
    }

    func userDidSignIn() {
        calls.userDidSignIn = true
    }
}
