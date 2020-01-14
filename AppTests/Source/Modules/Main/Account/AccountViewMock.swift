//
//  AccountViewMock.swift
//  MoviesTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Movies

class AccountViewMock: AccountViewProtocol {
    struct Calls {
        var populateWithState = false
        var populateWithUser = false
        var presentSignOutError = false
        var userDidSignOut = false
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

    func populate(with user: User) {
        calls.populateWithUser = true
    }

    func presentSignOutError(_ error: Error) {
        calls.presentSignOutError = true
    }

    func userDidSignOut() {
        calls.userDidSignOut = true
    }
}
