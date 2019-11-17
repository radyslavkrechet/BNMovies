//
//  PaginationViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

class PaginationViewController<V: PaginationViewModelProtocol,
    P: PaginationProviderProtocol>: ListViewController<V, P> {

    let refreshControl = UIRefreshControl()

    // MARK: - Setup

    override func setupBinding() {
        super.setupBinding()

        refreshControl.rx.controlEvent(.valueChanged)
            .do(onNext: { [weak self] _ in
                self?.refreshControlDidPull()
            })
            .bind(to: viewModel.refreshControlDidPull)
            .disposed(by: disposeBag)

        recyclerProvider.lastItemWillDisplay.subscribe(onNext: { [weak self] _ in
            self?.lastItemWillDisplay()
        }).disposed(by: disposeBag)
    }

    private func refreshControlDidPull() {
        analyticsManager?.logPullToRefresh(in: self.nameOfClass)
    }

    private func lastItemWillDisplay() {
        analyticsManager?.logPagination(in: self.nameOfClass)

        viewModel.getMoreContent()
    }
}
