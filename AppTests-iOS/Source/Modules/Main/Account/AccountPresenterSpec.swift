//
//  AccountPresenterSpec.swift
//  MoviesTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Movies

class AccountPresenterSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var accountPresenter: AccountPresenter!
        var getUserUseCaseMock: GetUserUseCaseMock!
        var signOutUseCaseMock: SignOutUseCaseMock!
        var accountViewMock: AccountViewMock!

        beforeEach {
            getUserUseCaseMock = GetUserUseCaseMock()
            signOutUseCaseMock = SignOutUseCaseMock()
            accountPresenter = AccountPresenter(getUserUseCase: getUserUseCaseMock, signOutUseCase: signOutUseCaseMock)

            accountViewMock = AccountViewMock()
            accountPresenter.view = accountViewMock
        }

        describe("get content") {
            context("get user use case executes -> error") {
                it("populates view with loading state, populates view with error state") {
                    getUserUseCaseMock.settings.shouldReturnError = true

                    accountPresenter.getContent()

                    expect(getUserUseCaseMock.calls.execute) == true
                    expect(accountViewMock.calls.populateWithState) == true
                    expect(accountViewMock.arguments.states) == [.loading, .error(Mock.Error.force)]
                }
            }

            context("get user use case executes -> user") {
                it("populates view with loading state, populates view with content state and user") {
                    accountPresenter.getContent()

                    expect(getUserUseCaseMock.calls.execute) == true
                    expect(accountViewMock.calls.populateWithState) == true
                    expect(accountViewMock.arguments.states) == [.loading, .content]
                    expect(accountViewMock.calls.populateWithUser) == true
                }
            }
        }

        describe("try again") {
            context("get user use case executes -> error") {
                it("populates view with loading state, populates view with error state") {
                    getUserUseCaseMock.settings.shouldReturnError = true

                    accountPresenter.tryAgain()

                    expect(getUserUseCaseMock.calls.execute) == true
                    expect(accountViewMock.calls.populateWithState) == true
                    expect(accountViewMock.arguments.states) == [.loading, .error(Mock.Error.force)]
                }
            }

            context("get user use case executes -> user") {
                it("populates view with loading state, populates view with content state and user") {
                    accountPresenter.tryAgain()

                    expect(getUserUseCaseMock.calls.execute) == true
                    expect(accountViewMock.calls.populateWithState) == true
                    expect(accountViewMock.arguments.states) == [.loading, .content]
                    expect(accountViewMock.calls.populateWithUser) == true
                }
            }
        }

        describe("sign out") {
            context("sign out use case executes -> error") {
                it("notifies view that error presentation needed") {
                    signOutUseCaseMock.settings.shouldReturnError = true

                    accountPresenter.signOut()

                    expect(signOutUseCaseMock.calls.execute) == true
                    expect(accountViewMock.calls.presentSignOutError) == true
                }
            }

            context("sign out use case executes -> void") {
                it("notifies view that user did sign out") {
                    accountPresenter.signOut()

                    expect(signOutUseCaseMock.calls.execute) == true
                    expect(accountViewMock.calls.userDidSignOut) == true
                }
            }
        }
    }
}
