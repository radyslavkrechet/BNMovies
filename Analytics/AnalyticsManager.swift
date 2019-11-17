//
//  AnalyticsManager.swift
//  Analytics
//
//  Created by Radyslav Krechet on 9/12/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Firebase

private let keys = (eventCategory: "eventCategory", eventLabel: "eventLabel")

struct AnalyticsManager: AnalyticsManagerProtocol {
    private enum Event: String {
        case presentation, click, pagination, pullToRefresh, itemSelection, signIn, signOut
    }

    static func setup() {
        FirebaseApp.configure()
    }

    func logPresentation(of responder: String) {
        logEvent(.presentation, responder: responder)
    }

    func logClick(in responder: String, senderTitle: String) {
        logEvent(.click, responder: responder, label: senderTitle)
    }

    func logPagination(in responder: String) {
        logEvent(.pagination, responder: responder)
    }

    func logPullToRefresh(in responder: String) {
        logEvent(.pullToRefresh, responder: responder)
    }

    func logItemSelection(in responder: String, itemId: String) {
        logEvent(.itemSelection, responder: responder, label: itemId)
    }

    func logSignIn() {
        logEvent(.signIn)
    }

    func logSignOut() {
        logEvent(.signOut)
    }

    private func logEvent(_ event: Event, responder: String? = nil, label: String? = nil) {
        var parameters = [String: String]()
        if let responder = responder {
            parameters[keys.eventCategory] = responder
        }
        if let label = label {
            parameters[keys.eventLabel] = label
        }

        Analytics.logEvent(event.rawValue, parameters: parameters.isEmpty ? nil : parameters)
    }
}
