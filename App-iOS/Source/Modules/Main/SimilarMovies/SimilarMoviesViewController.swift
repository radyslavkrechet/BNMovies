//
//  SimilarMoviesViewController.swift
//  Movies
//
//  Created by Radyslav Krechet on 9/6/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Core
import Domain

protocol SimilarMoviesViewProtocol: ListViewProtocol {
    func populate(with movies: [Movie])
}

class SimilarMoviesViewController: ListViewController<SimilarMoviesPresenter, SimilarMoviesDataSource>,
    SimilarMoviesViewProtocol {

    @IBOutlet private(set) weak var collectionView: UICollectionView!

    override var emptyStateText: String {
        return "SimilarMoviesViewController.emptyStateText".localized
    }

    // MARK: - Lifecycle

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let deailsViewController = segue.destination as? DetailsViewController, let id = sender as? String {
            deailsViewController.presenter.id = id
        }
    }

    // MARK: - Setup

    override func setupViews() {
        super.setupViews()

        collectionView.registerNibForCell(SimilarMovieCollectionViewCell.self)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }

    // MARK: - DataSource

    override func userDidSelectItem(_ item: Movie) {
        super.userDidSelectItem(item)

        present(.Details, with: item.id)
    }

    // MARK: - SimilarMoviesViewProtocol

    func populate(with movies: [Movie]) {
        dataSource.populate(with: movies)
        collectionView.reloadData()
    }
}
