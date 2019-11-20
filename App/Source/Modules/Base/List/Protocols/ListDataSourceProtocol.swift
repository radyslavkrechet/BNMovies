//
//  ListDataSourceProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/29/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol ListDataSourceProtocol: class {
    associatedtype Item: Identifiable

    var userDidSelectItem: ((Item) -> Void)? { get set }

    func populate(with items: [Item])
}

protocol ListTableDataSourceProtocol: ListDataSourceProtocol, UITableViewDataSource, UITableViewDelegate {}
protocol ListCollectionDataSourceProtocol: ListDataSourceProtocol, UICollectionViewDataSource,
    UICollectionViewDelegate {}
