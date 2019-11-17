//
//  AnalyticsManagerProtocol.swift
//  Analytics
//
//  Created by Radyslav Krechet on 9/12/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

protocol AnalyticsManagerProtocol {
    func logPresentation(of responder: String)
    func logClick(in responder: String, senderTitle: String)
    func logPagination(in responder: String)
    func logPullToRefresh(in responder: String)
    func logItemSelection(in responder: String, itemId: String)
    func logSignIn()
    func logSignOut()
}
