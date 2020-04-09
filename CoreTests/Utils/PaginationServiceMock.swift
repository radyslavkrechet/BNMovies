//
//  PaginationServiceMock.swift
//  CoreTests
//
//  Created by Radyslav Krechet on 09.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

@testable import Core

class PaginationServiceMock: PaginationServiceProtocol {
    struct Calls {
        var startLoading = false
        var stopLoading = false
        var reset = false
    }

    struct Arguments {
        var itemsCount: Int?
    }

    var calls = Calls()
    var arguments = Arguments()

    var page = 0
    var canGetMore = true
    var isFirstPage = true

    func startLoading() {
        calls.startLoading = true
        page += 1
    }

    func stopLoading(with itemsCount: Int) {
        calls.stopLoading = true
        arguments.itemsCount = itemsCount

        canGetMore = itemsCount > 0
        isFirstPage = false
    }

    func reset() {
        calls.reset = true

        page = 0
        canGetMore = true
        isFirstPage = true
    }
}
