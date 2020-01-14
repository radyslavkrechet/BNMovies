//
//  SplashPresenterSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Movies

class SplashPresenterSpec: QuickSpec {
    override func spec() {
        var splashPresenter: SplashPresenter!
        var checkSessionUseCaseMock: CheckSessionUseCaseMock!
        var splashViewMock: SplashViewMock!

        beforeEach {
            checkSessionUseCaseMock = CheckSessionUseCaseMock()
            splashPresenter = SplashPresenter(checkSessionUseCase: checkSessionUseCaseMock)

            splashViewMock = SplashViewMock()
            splashPresenter.view = splashViewMock
        }

        describe("get content") {
            context("check session use case executes -> error") {
                it("populates view with error state") {
                    checkSessionUseCaseMock.settings.shouldReturnError = true

                    splashPresenter.getContent()

                    expect(checkSessionUseCaseMock.calls.execute) == true
                    expect(splashViewMock.calls.populate) == true
                    expect(splashViewMock.arguments.states) == [.error(Mock.Error.force)]
                }
            }

            context("check session use case executes -> bool") {
                it("notifies view that navigation needed") {
                    splashPresenter.getContent()

                    expect(checkSessionUseCaseMock.calls.execute) == true
                    expect(splashViewMock.calls.navigate) == true
                    expect(splashViewMock.arguments.isSignedIn) == checkSessionUseCaseMock.settings.shouldReturnTrue
                }
            }
        }

        describe("try again") {
            context("check session use case executes -> error") {
                it("populates view with error state") {
                    checkSessionUseCaseMock.settings.shouldReturnError = true

                    splashPresenter.tryAgain()

                    expect(checkSessionUseCaseMock.calls.execute) == true
                    expect(splashViewMock.calls.populate) == true
                    expect(splashViewMock.arguments.states) == [.error(Mock.Error.force)]
                }
            }

            context("check session use case executes -> bool") {
                it("notifies view that navigation needed") {
                    splashPresenter.tryAgain()

                    expect(checkSessionUseCaseMock.calls.execute) == true
                    expect(splashViewMock.calls.navigate) == true
                    expect(splashViewMock.arguments.isSignedIn) == checkSessionUseCaseMock.settings.shouldReturnTrue
                }
            }
        }
    }
}
