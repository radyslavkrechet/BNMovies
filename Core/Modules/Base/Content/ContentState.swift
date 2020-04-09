//
//  ContentState.swift
//  Core
//
//  Created by Radyslav Krechet on 17.11.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

public enum ContentState: Equatable {
    case loading, empty, content, error(_ error: Error)

    public static func == (lhs: ContentState, rhs: ContentState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.empty, .empty), (.content, .content), (.error, .error): return true
        default: return false
        }
    }
}
