//
//  AnalyticsServiceSpec.swift
//  BoilerplateTests
//
//  Created by Radyslav Krechet on 06.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Boilerplate

class AnalyticsServiceSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        let responder = "responder"
        let label = "label"

        var analyticsService: AnalyticsService!
        var analyticsManagerMock: AnalyticsManagerMock!

        beforeEach {
            analyticsManagerMock = AnalyticsManagerMock()
            analyticsService = AnalyticsService(analyticsManager: analyticsManagerMock)
        }

        describe("log presentation") {
            it("logs event with manager") {
                analyticsService.logPresentation(of: responder)

                expect(analyticsManagerMock.calls.logEventWithResponder) == true
                expect(analyticsManagerMock.arguments.event) == .presentation
                expect(analyticsManagerMock.arguments.responder) == responder
            }
        }

        describe("log click") {
            it("logs event with manager") {
                analyticsService.logClick(in: responder, senderTitle: label)

                expect(analyticsManagerMock.calls.logEventWithResponderAndLabel) == true
                expect(analyticsManagerMock.arguments.event) == .click
                expect(analyticsManagerMock.arguments.responder) == responder
                expect(analyticsManagerMock.arguments.label) == label
            }
        }

        describe("log pagination") {
            it("logs event with manager") {
                analyticsService.logPagination(in: responder)

                expect(analyticsManagerMock.calls.logEventWithResponder) == true
                expect(analyticsManagerMock.arguments.event) == .pagination
                expect(analyticsManagerMock.arguments.responder) == responder
            }
        }

        describe("log pull to refresh") {
            it("logs event with manager") {
                analyticsService.logPullToRefresh(in: responder)

                expect(analyticsManagerMock.calls.logEventWithResponder) == true
                expect(analyticsManagerMock.arguments.event) == .pullToRefresh
                expect(analyticsManagerMock.arguments.responder) == responder
            }
        }

        describe("log item selection") {
            it("logs event with manager") {
                analyticsService.logItemSelection(in: responder, itemId: label)

                expect(analyticsManagerMock.calls.logEventWithResponderAndLabel) == true
                expect(analyticsManagerMock.arguments.event) == .itemSelection
                expect(analyticsManagerMock.arguments.responder) == responder
                expect(analyticsManagerMock.arguments.label) == label
            }
        }

        describe("log sign in") {
            it("logs event with manager") {
                analyticsService.logSignIn()

                expect(analyticsManagerMock.calls.logEvent) == true
                expect(analyticsManagerMock.arguments.event) == .signIn
            }
        }

        describe("log sign out") {
            it("logs event with manager") {
                analyticsService.logSignOut()

                expect(analyticsManagerMock.calls.logEvent) == true
                expect(analyticsManagerMock.arguments.event) == .signOut
            }
        }
    }
}
