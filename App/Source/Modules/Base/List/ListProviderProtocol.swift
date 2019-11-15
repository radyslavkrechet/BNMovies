//
//  ListProviderProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/29/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import RxSwift

protocol ListProviderProtocol {
    associatedtype Item: Identifiable

    var items: Variable<[Item]> { get }
    var userDidSelectItem: Observable<Item> { get }
}

protocol ListTableProviderProtocol: ListProviderProtocol, UITableViewDataSource, UITableViewDelegate {}
protocol ListCollectionProviderProtocol: ListProviderProtocol, UICollectionViewDataSource, UICollectionViewDelegate {}
