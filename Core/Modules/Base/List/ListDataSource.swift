//
//  ListDataSource.swift
//  Core
//
//  Created by Radyslav Krechet on 8/29/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

public protocol ListDataSourceProtocol: class {
    associatedtype Item: Identifiable

    var userDidSelectItem: ((Item) -> Void)? { get set }

    func populate(with items: [Item])
}

public protocol ListTableDataSourceProtocol: ListDataSourceProtocol, UITableViewDataSource, UITableViewDelegate {}
public protocol ListCollectionDataSourceProtocol: ListDataSourceProtocol, UICollectionViewDataSource,
    UICollectionViewDelegate {}
