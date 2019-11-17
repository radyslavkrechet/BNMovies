//
//  SimilarMoviesCollectionProvider.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/6/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import RxSwift

class SimilarMoviesCollectionProvider: NSObject, ListCollectionProviderProtocol {
    let items = Variable<[Movie]>([])

    private(set) lazy var userDidSelectItem: Observable<Movie> = userDidSelectItemSubject.observeOnMain()

    private let userDidSelectItemSubject = PublishSubject<Movie>()

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.value.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let movie = items.value[indexPath.row]
        let cell: SimilarMovieCollectionViewCell = collectionView.dequeueReusableCellForIndexPath(indexPath)
        cell.populate(with: movie)
        return cell
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let movie = items.value[indexPath.row]
        userDidSelectItemSubject.onNext(movie)
    }
}
