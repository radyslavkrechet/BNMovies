//
//  PaginationPresenter.swift
//  Core
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol PaginationPresenterProtocol: ListPresenterProtocol {
    #if !os(tvOS)
    func refreshContent()
    #endif

    func getMoreContent()
}
