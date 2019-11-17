//
//  ContentViewModelProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import RxSwift

enum ContentState: Equatable {
    case loading, empty, content, error(_ error: Error)

    // MARK: - Equatable

    static func == (lhs: ContentState, rhs: ContentState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.empty, .empty), (.content, .content), (.error, .error):
            return true
        default:
            return false
        }
    }
}

protocol ContentViewModelProtocol: ViewModelProtocol {
    var state: Observable<ContentState> { get }

    func getContent()
    func tryAgain()
}
