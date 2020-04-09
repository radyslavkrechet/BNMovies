//
//  PaginationViewController.swift
//  Core
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import UIKit

public protocol PaginationViewProtocol: ListViewProtocol {}

open class PaginationViewController<Presenter: PaginationPresenterProtocol,
    DataSource: PaginationDataSourceProtocol>: ListViewController<Presenter, DataSource>, PaginationViewProtocol {

    #if !os(tvOS)
    public let refreshControl = UIRefreshControl()

    // MARK: - Setup

    open override func setupViews() {
        super.setupViews()

        refreshControl.addTarget(self, action: #selector(refreshControlDidPull), for: .valueChanged)
    }

    @objc private func refreshControlDidPull() {
        presenter.refreshContent()
    }
    #endif

    open override func setupDataSource() {
        super.setupDataSource()

        dataSource.lastItemWillDisplay = { [weak self] in
            self?.lastItemWillDisplay()
        }
    }

    // MARK: - DataSource

    func lastItemWillDisplay() {
        presenter.getMoreContent()
    }
}
