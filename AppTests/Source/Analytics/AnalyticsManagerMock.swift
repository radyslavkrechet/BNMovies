//
//  AnalyticsManagerMock.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 06.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

@testable import Boilerplate

class AnalyticsManagerMock: AnalyticsManagerProtocol {
    struct Calls {
        var logEvent = false
        var logEventWithResponder = false
        var logEventWithResponderAndLabel = false
    }

    struct Arguments {
        var event: AnalyticsEvent?
        var responder: String?
        var label: String?
    }

    var calls = Calls()
    var arguments = Arguments()

    func logEvent(_ event: AnalyticsEvent) {
        calls.logEvent = true
        arguments.event = event
    }

    func logEvent(_ event: AnalyticsEvent, responder: String) {
        calls.logEventWithResponder = true
        arguments.event = event
        arguments.responder = responder
    }

    func logEvent(_ event: AnalyticsEvent, responder: String, label: String) {
        calls.logEventWithResponderAndLabel = true
        arguments.event = event
        arguments.responder = responder
        arguments.label = label
    }
}
