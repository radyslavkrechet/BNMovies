//
//  ContentState.swift
//  Movies
//
//  Created by Radyslav Krechet on 17.11.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

enum ContentState: Equatable {
    case loading, empty, content, error(_ error: Error)

    static func == (lhs: ContentState, rhs: ContentState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.empty, .empty), (.content, .content), (.error, .error): return true
        default: return false
        }
    }
}
