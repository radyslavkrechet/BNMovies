//
//  PaginationViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

class PaginationViewController<Presenter: PaginationPresenterProtocol,
    DataSource: PaginationDataSourceProtocol>: ListViewController<Presenter, DataSource>, PaginationViewProtocol {

    let refreshControl = UIRefreshControl()

    // MARK: - Setup

    override func setupViews() {
        super.setupViews()

        refreshControl.addTarget(self, action: #selector(refreshControlDidPull), for: .valueChanged)
    }

    @objc private func refreshControlDidPull() {
        analyticsManager?.logPullToRefresh(in: self.nameOfClass)
        presenter.refreshContent()
    }

    override func setupDataSource() {
        super.setupDataSource()

        dataSource.lastItemWillDisplay = lastItemWillDisplay
    }

    // MARK: - DataSource

    func lastItemWillDisplay() {
        analyticsManager?.logPagination(in: self.nameOfClass)
        presenter.getMoreContent()
    }
}
