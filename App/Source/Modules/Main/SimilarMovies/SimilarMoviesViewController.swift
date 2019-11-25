//
//  SimilarMoviesViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/6/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol SimilarMoviesViewProtocol: ListViewProtocol {
    func populate(with movies: [Movie])
}

class SimilarMoviesViewController<Presenter: SimilarMoviesPresenterProtocol,
    DataSource: SimilarMoviesDataSourceProtocol>: ListViewController<Presenter, DataSource>, SimilarMoviesViewProtocol {

    @IBOutlet private(set) weak var collectionView: UICollectionView!

    override var emptyStateText: String {
        return "SimilarMoviesViewController.emptyStateText".localized
    }

    // MARK: - Lifecycle

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let deailsViewController = segue.destination as? DetailsViewController<DetailsPresenter>,
            let movie = sender as? Movie {

            deailsViewController.presenter.id = movie.id
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

        present(.Details, with: item)
    }

    // MARK: - SimilarMoviesViewProtocol

    func populate(with movies: [Movie]) {
        dataSource.populate(with: movies)
        collectionView.reloadData()
    }
}
