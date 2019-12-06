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
    var page: Int { get }
    var canGetMore: Bool { get }
    var isFirstPage: Bool { get }

    mutating func startLoading()
    mutating func stopLoading(with itemsCount: Int)
    mutating func reset()
}

struct PaginationService: PaginationServiceProtocol {
    private(set) var page = onePageValue

    var canGetMore: Bool {
        return !isLoading && lastPageItemsCount == itemsPerPage
    }
    var isFirstPage: Bool {
        return page == onePageValue
    }

    private var isLoading = false
    private var lastPageItemsCount = itemsPerPage

    mutating func startLoading() {
        isLoading = true
    }

    mutating func stopLoading(with itemsCount: Int) {
        isLoading = false
        page += onePageValue
        lastPageItemsCount = itemsCount
    }

    mutating func reset() {
        isLoading = false
        lastPageItemsCount = itemsPerPage
        page = onePageValue
    }
}
