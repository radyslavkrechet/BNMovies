//
//  SignInPresenterSpec.swift
//  MoviesTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Movies

class SignInPresenterSpec: QuickSpec {
    override func spec() {
        var signInPresenter: SignInPresenter!
        var signInUseCaseMock: SignInUseCaseMock!
        var signInViewMock: SignInViewMock!

        beforeEach {
            signInUseCaseMock = SignInUseCaseMock()
            signInPresenter = SignInPresenter(signInUseCase: signInUseCaseMock)

            signInViewMock = SignInViewMock()
            signInPresenter.view = signInViewMock
        }

        describe("sign in") {
            let username = "username"
            let password = "password"

            context("sign in use case executes -> error") {
                it("populates view with loading state, populates view with error state") {
                    signInUseCaseMock.settings.shouldReturnError = true

                    signInPresenter.signIn(with: username, password: password)

                    expect(signInUseCaseMock.calls.execute) == true
                    expect(signInUseCaseMock.arguments.username) == username
                    expect(signInUseCaseMock.arguments.password) == password

                    expect(signInViewMock.calls.populate) == true
                    expect(signInViewMock.arguments.states) == [.loading, .error(Mock.Error.force)]
                }
            }

            context("sign in use case executes -> user") {
                it("populates view with loading state, notifies view that user did sign in") {
                    signInPresenter.signIn(with: username, password: password)

                    expect(signInUseCaseMock.calls.execute) == true
                    expect(signInUseCaseMock.arguments.username) == username
                    expect(signInUseCaseMock.arguments.password) == password

                    expect(signInViewMock.calls.populate) == true
                    expect(signInViewMock.arguments.states) == [.loading]
                    expect(signInViewMock.calls.userDidSignIn) == true
                }
            }
        }
    }
}
