//
//  ListViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/29/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

class ListViewController<V: ListViewModelProtocol, P: ListProviderProtocol>: ContentViewController<V> {
    var recyclerProvider: P!

    // MARK: - Setup

    override func setupBinding() {
        super.setupBinding()

        recyclerProvider.userDidSelectItem.subscribe(onNext: { [weak self] item in
            self?.userDidSelectItem(item)
        }).disposed(by: disposeBag)
    }

    func userDidSelectItem(_ item: P.Item) {
        analyticsManager?.logItemSelection(in: self.nameOfClass, itemId: item.id)
    }
}
