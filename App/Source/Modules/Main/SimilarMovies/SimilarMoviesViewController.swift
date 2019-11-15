//
//  SimilarMoviesViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/6/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import UIKit

class SimilarMoviesViewController: ListViewController<SimilarMoviesViewModel, SimilarMoviesCollectionProvider> {
    @IBOutlet private(set) weak var collectionView: UICollectionView!

    override var emptyStateText: String {
        return "SimilarMoviesViewController.emptyStateText".localized
    }

    // MARK: - Setup

    override func setupViews() {
        super.setupViews()

        collectionView.registerNibForCell(SimilarMovieCollectionViewCell.self)
        collectionView.dataSource = recyclerProvider
        collectionView.delegate = recyclerProvider
    }

    override func setupBinding() {
        super.setupBinding()

        viewModel.movies.subscribe(onNext: { [weak self] movies in
            self?.process(movies)
        }).disposed(by: disposeBag)
    }

    private func process(_ movies: [Movie]) {
        recyclerProvider.items.value = movies
        collectionView.reloadData()
    }

    override func userDidSelectItem(_ item: Movie) {
        super.userDidSelectItem(item)

        present(.Details, with: item)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let deailsViewController = segue.destination as? DetailsViewController, let movie = sender as? Movie {
            deailsViewController.viewModel.id = movie.id
        }
    }
}
