//
//  DebuggingManager.swift
//  Movies
//
//  Created by Radyslav Krechet on 9/11/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import FLEX

enum DebuggingManager {
    static func setup() {
        FLEXManager.shared()?.isNetworkDebuggingEnabled = true
    }

    static func toggleExplorer() {
        FLEXManager.shared()?.toggleExplorer()
    }
}
