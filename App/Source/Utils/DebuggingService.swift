//
//  DebuggingService.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/11/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import FLEX

enum DebuggingService {
    static func setup() {
        FLEXManager.shared()?.isNetworkDebuggingEnabled = true
    }

    static func toggleExplorer() {
        FLEXManager.shared()?.toggleExplorer()
    }
}
