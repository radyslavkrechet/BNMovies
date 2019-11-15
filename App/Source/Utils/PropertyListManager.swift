//
//  PropertyListManager.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/4/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

private let file = (name: "Info", type: "plist")

struct PropertyListManager {
    let properties: [String: Any]

    init() {
        guard let path = Bundle.main.path(forResource: file.name, ofType: file.type),
            let properties = NSDictionary(contentsOfFile: path) as? [String: Any] else {

                preconditionFailure("Failed to load property list")
        }

        self.properties = properties
    }
}
