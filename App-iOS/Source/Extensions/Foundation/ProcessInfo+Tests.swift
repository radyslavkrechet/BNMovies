//
//  ProcessInfo+Tests.swift
//  Movies
//
//  Created by Radyslav Krechet on 06.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

extension ProcessInfo {
    static var shouldLaunchApp: Bool {
        ProcessInfo.processInfo.environment["XCInjectBundleInto"] == nil
    }
}
