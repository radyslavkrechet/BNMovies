//
//  FavouritesViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol FavouritesViewProtocol: ListViewProtocol {
    func populate(with movies: [Movie])
}

class FavouritesViewController: ListViewController<FavouritesPresenter, MoviesDataSource>, FavouritesViewProtocol {
    @IBOutlet private(set) weak var tableView: UITableView!

    override var emptyStateText: String {
        return "FavouritesViewController.emptyStateText".localized
    }

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.getContent()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let deailsViewController = segue.destination as? DetailsViewController, let movie = sender as? Movie {
            deailsViewController.presenter.id = movie.id
        }
    }

    // MARK: - Setup

    override func setupViews() {
        super.setupViews()

        tableView.registerNibForCell(MovieTableViewCell.self)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }

    // MARK: - DataSource

    override func userDidSelectItem(_ item: Movie) {
        super.userDidSelectItem(item)

        present(.Details, with: item)
    }

    // MARK: - FavouritesViewProtocol

    func populate(with movies: [Movie]) {
        dataSource.populate(with: movies)
        tableView.reloadData()
    }
}
