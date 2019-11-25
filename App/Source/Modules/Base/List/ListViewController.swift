//
//  ListViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/29/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol ListViewProtocol: ContentViewProtocol {}

class ListViewController<Presenter: ListPresenterProtocol,
    DataSource: ListDataSourceProtocol>: ContentViewController<Presenter>, ListViewProtocol {

    var dataSource: DataSource!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDataSource()
    }

    // MARK: - Setup

    func setupDataSource() {
        dataSource.userDidSelectItem = userDidSelectItem
    }

    // MARK: - DataSource

    func userDidSelectItem(_ item: DataSource.Item) {
        analyticsManager?.logItemSelection(in: self.nameOfClass, itemId: item.id)
    }
}
