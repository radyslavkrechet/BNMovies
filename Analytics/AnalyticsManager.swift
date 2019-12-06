//
//  AnalyticsManager.swift
//  Analytics
//
//  Created by Radyslav Krechet on 9/12/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Firebase

private let keys = (eventCategory: "eventCategory", eventLabel: "eventLabel")

protocol AnalyticsManagerProtocol {
    func logEvent(_ event: AnalyticsEvent)
    func logEvent(_ event: AnalyticsEvent, responder: String)
    func logEvent(_ event: AnalyticsEvent, responder: String, label: String)
}

struct AnalyticsManager: AnalyticsManagerProtocol {
    init() {
        FirebaseApp.configure()
    }

    func logEvent(_ event: AnalyticsEvent) {
        Analytics.logEvent(event.rawValue, parameters: nil)
    }

    func logEvent(_ event: AnalyticsEvent, responder: String) {
        let parameters = [keys.eventCategory: responder]
        Analytics.logEvent(event.rawValue, parameters: parameters)
    }

    func logEvent(_ event: AnalyticsEvent, responder: String, label: String) {
        let parameters = [keys.eventCategory: responder, keys.eventLabel: label]
        Analytics.logEvent(event.rawValue, parameters: parameters)
    }
}
