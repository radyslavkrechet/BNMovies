//
//  MoviesDataSource.swift
//  Movies
//
//  Created by Radyslav Krechet on 10.04.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Core
import Domain

protocol MoviesDataSourceProtocol: PaginationCollectionDataSourceProtocol where Item == Movie {}

class MoviesDataSource: NSObject, MoviesDataSourceProtocol {
    var userDidSelectItem: ((Movie) -> Void)?
    var lastItemWillDisplay: (() -> Void)?

    private var items = [Movie]()

    func populate(with items: [Movie]) {
        self.items = items
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let movie = items[indexPath.item]
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCellForIndexPath(indexPath)
        cell.populate(with: movie)
        return cell
    }

    // MARK: - UITableViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let movie = items[indexPath.row]
        userDidSelectItem?(movie)
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {

        if indexPath.item == items.count - 1 {
            lastItemWillDisplay?()
        }
    }
}
