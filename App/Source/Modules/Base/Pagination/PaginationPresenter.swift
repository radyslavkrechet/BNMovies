//
//  PaginationPresenter.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

protocol PaginationPresenterProtocol: ListPresenterProtocol {
    func refreshContent()
    func getMoreContent()
}
