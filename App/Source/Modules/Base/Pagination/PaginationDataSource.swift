//
//  PaginationDataSource.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/29/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

protocol PaginationDataSourceProtocol: ListDataSourceProtocol {
    var lastItemWillDisplay: (() -> Void)? { get set }
}

protocol PaginationTableDataSourceProtocol: PaginationDataSourceProtocol, UITableViewDataSource, UITableViewDelegate {}
protocol PaginationCollectionDataSourceProtocol: PaginationDataSourceProtocol, UICollectionViewDataSource,
    UICollectionViewDelegate {}
