//
//  ListViewController.swift
//  Core
//
//  Created by Radyslav Krechet on 8/29/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

public protocol ListViewProtocol: ContentViewProtocol {}

open class ListViewController<Presenter: ListPresenterProtocol,
    DataSource: ListDataSourceProtocol>: ContentViewController<Presenter>, ListViewProtocol {

    public var dataSource: DataSource!

    // MARK: - Lifecycle

    open override func viewDidLoad() {
        super.viewDidLoad()

        setupDataSource()
    }

    // MARK: - Setup

    open func setupDataSource() {
        dataSource.userDidSelectItem = { [weak self] item in
            self?.userDidSelectItem(item)
        }
    }

    // MARK: - DataSource

    open func userDidSelectItem(_ item: DataSource.Item) {}
}
