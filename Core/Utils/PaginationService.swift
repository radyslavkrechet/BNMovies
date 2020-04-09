//
//  PaginationService.swift
//  Core
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

private let onePageValue = 1
private let itemsPerPage = 20

public protocol PaginationServiceProtocol {
    var page: Int { get }
    var canGetMore: Bool { get }
    var isFirstPage: Bool { get }

    func startLoading()
    func stopLoading(with itemsCount: Int)
    func reset()
}

public class PaginationService: PaginationServiceProtocol {
    public private(set) var page = onePageValue

    public var canGetMore: Bool {
        return !isLoading && lastPageItemsCount == itemsPerPage
    }
    public var isFirstPage: Bool {
        return page == onePageValue
    }

    private var isLoading = false
    private var lastPageItemsCount = itemsPerPage

    public init() {}

    public func startLoading() {
        isLoading = true
    }

    public func stopLoading(with itemsCount: Int) {
        isLoading = false
        page += onePageValue
        lastPageItemsCount = itemsCount
    }

    public func reset() {
        isLoading = false
        lastPageItemsCount = itemsPerPage
        page = onePageValue
    }
}
