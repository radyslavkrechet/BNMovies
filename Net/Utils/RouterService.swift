//
//  RouterService.swift
//  Net
//
//  Created by Radyslav Krechet on 25.11.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

enum RouterService {
    static func setup(with serverSettings: ServerSettings) {
        AuthRouter.serverSettings = serverSettings
        UserRouter.serverSettings = serverSettings
        MovieRouter.serverSettings = serverSettings
    }
}
