//
//  ContentState.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 17.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

enum ContentState {
    case loading, empty, content, error(_ error: Error)
}
