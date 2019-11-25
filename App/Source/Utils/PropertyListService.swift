//
//  PropertyListService.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/4/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

private let file = (name: "Info", type: "plist")

enum PropertyListService {
    static var properties: [String: Any] {
        guard let path = Bundle.main.path(forResource: file.name, ofType: file.type),
            let properties = NSDictionary(contentsOfFile: path) as? [String: Any] else {

                preconditionFailure("Failed to load property list")
        }

        return properties
    }
}
