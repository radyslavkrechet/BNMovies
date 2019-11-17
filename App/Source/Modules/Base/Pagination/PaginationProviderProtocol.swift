//
//  PaginationProviderProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/29/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import RxSwift

protocol PaginationProviderProtocol: ListProviderProtocol {
    var lastItemWillDisplay: Observable<Void> { get }
}

protocol PaginationTableProviderProtocol: PaginationProviderProtocol, UITableViewDataSource, UITableViewDelegate {}
protocol PaginationCollectionProviderProtocol: PaginationProviderProtocol, UICollectionViewDataSource,
    UICollectionViewDelegate {}
