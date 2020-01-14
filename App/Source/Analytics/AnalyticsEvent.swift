//
//  AnalyticsEvent.swift
//  Movies
//
//  Created by Radyslav Krechet on 06.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

enum AnalyticsEvent: String, Equatable {
    case presentation, click, pagination, pullToRefresh, itemSelection, signIn, signOut
}
