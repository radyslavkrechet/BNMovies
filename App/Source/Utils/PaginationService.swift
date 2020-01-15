//
//  PaginationService.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

private let onePageValue = 1
private let itemsPerPage = 20

protocol PaginationServiceProtocol {
    var page: Int { get }
    var canGetMore: Bool { get }
    var isFirstPage: Bool { get }

    func startLoading()
    func stopLoading(with itemsCount: Int)
    func reset()
}

class PaginationService: PaginationServiceProtocol {
    private(set) var page = onePageValue

    var canGetMore: Bool {
        return !isLoading && lastPageItemsCount == itemsPerPage
    }
    var isFirstPage: Bool {
        return page == onePageValue
    }

    private var isLoading = false
    private var lastPageItemsCount = itemsPerPage

    func startLoading() {
        isLoading = true
    }

    func stopLoading(with itemsCount: Int) {
        isLoading = false
        page += onePageValue
        lastPageItemsCount = itemsCount
    }

    func reset() {
        isLoading = false
        lastPageItemsCount = itemsPerPage
        page = onePageValue
    }
}
