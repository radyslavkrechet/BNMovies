//
//  PaginationService.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

private let onePageValue = 1
private let itemsPerPage = 20

protocol PaginationServiceProtocol {
    var value: Int { get }
    var canGetMore: Bool { get }
    var isFirstPage: Bool { get }

    mutating func startLoading()
    mutating func stopLoading(with itemsCount: Int)
    mutating func reset()
}

struct PaginationService: PaginationServiceProtocol {
    private(set) var value = onePageValue

    var canGetMore: Bool {
        return !isLoading && lastPageItemsCount == itemsPerPage
    }
    var isFirstPage: Bool {
        return value == onePageValue
    }

    private var isLoading = false
    private var lastPageItemsCount = itemsPerPage

    mutating func startLoading() {
        isLoading = true
    }

    mutating func stopLoading(with itemsCount: Int) {
        isLoading = false
        value += onePageValue
        lastPageItemsCount = itemsCount
    }

    mutating func reset() {
        isLoading = false
        lastPageItemsCount = itemsPerPage
        value = onePageValue
    }
}
