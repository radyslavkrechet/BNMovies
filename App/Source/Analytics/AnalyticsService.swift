//
//  AnalyticsService.swift
//  Movies
//
//  Created by Radyslav Krechet on 06.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

protocol AnalyticsServiceProtocol {
    func logPresentation(of responder: String)
    func logClick(in responder: String, senderTitle: String)
    func logPagination(in responder: String)
    func logPullToRefresh(in responder: String)
    func logItemSelection(in responder: String, itemId: String)
    func logSignIn()
    func logSignOut()
}

struct AnalyticsService: AnalyticsServiceProtocol {
    private let analyticsManager: AnalyticsManagerProtocol

    init(analyticsManager: AnalyticsManagerProtocol) {
        self.analyticsManager = analyticsManager
    }

    func logPresentation(of responder: String) {
        analyticsManager.logEvent(.presentation, responder: responder)
    }

    func logClick(in responder: String, senderTitle: String) {
        analyticsManager.logEvent(.click, responder: responder, label: senderTitle)
    }

    func logPagination(in responder: String) {
        analyticsManager.logEvent(.pagination, responder: responder)
    }

    func logPullToRefresh(in responder: String) {
        analyticsManager.logEvent(.pullToRefresh, responder: responder)
    }

    func logItemSelection(in responder: String, itemId: String) {
        analyticsManager.logEvent(.itemSelection, responder: responder, label: itemId)
    }

    func logSignIn() {
        analyticsManager.logEvent(.signIn)
    }

    func logSignOut() {
        analyticsManager.logEvent(.signOut)
    }
}
