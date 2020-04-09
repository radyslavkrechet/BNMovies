//
//  PaginationDataSource.swift
//  Core
//
//  Created by Radyslav Krechet on 8/29/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

public protocol PaginationDataSourceProtocol: ListDataSourceProtocol {
    var lastItemWillDisplay: (() -> Void)? { get set }
}

public protocol PaginationTableDataSourceProtocol: PaginationDataSourceProtocol, UITableViewDataSource,
    UITableViewDelegate {}
public protocol PaginationCollectionDataSourceProtocol: PaginationDataSourceProtocol, UICollectionViewDataSource,
    UICollectionViewDelegate {}
