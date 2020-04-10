//
//  MoviesViewController.swift
//  Movies
//
//  Created by Radyslav Krechet on 10.04.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Core
import Domain

protocol MoviesViewProtocol: PaginationViewProtocol {
    func populate(with movies: [Movie])
}

class MoviesViewController: PaginationViewController<MoviesPresenter, MoviesDataSource>, MoviesViewProtocol {
    @IBOutlet private(set) weak var collectionView: UICollectionView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        presenter.chart = Movie.Chart(rawValue: tabBarController!.selectedIndex)

        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let deailsViewController = segue.destination as? DetailsViewController, let id = sender as? String {
            deailsViewController.presenter.id = id
        }
    }

    // MARK: - Setup

    override func setupViews() {
        super.setupViews()

        collectionView.registerNibForCell(MovieCollectionViewCell.self)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }

    // MARK: - DataSource

    override func userDidSelectItem(_ item: Movie) {
        super.userDidSelectItem(item)

        performSegue(withIdentifier: "Details", sender: item.id)
    }

    // MARK: - HomeViewProtocol

    func populate(with movies: [Movie]) {
        dataSource.populate(with: movies)
        collectionView.reloadData()
    }
}
