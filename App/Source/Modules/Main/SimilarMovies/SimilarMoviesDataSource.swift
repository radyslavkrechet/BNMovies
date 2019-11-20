//
//  SimilarMoviesDataSource.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/6/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

class SimilarMoviesDataSource: NSObject, SimilarMoviesDataSourceProtocol {
    var userDidSelectItem: ((Movie) -> Void)?

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

        let movie = items[indexPath.row]
        let cell: SimilarMovieCollectionViewCell = collectionView.dequeueReusableCellForIndexPath(indexPath)
        cell.populate(with: movie)
        return cell
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let movie = items[indexPath.row]
        userDidSelectItem?(movie)
    }
}
