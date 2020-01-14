//
//  MoviesViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol MoviesViewProtocol: ListViewProtocol {
    func populate(with movies: [Movie])
}

class MoviesViewController: ListViewController<MoviesPresenter, MoviesDataSource>, MoviesViewProtocol {
    @IBOutlet private(set) weak var tableView: UITableView!

    override var emptyStateText: String {
        return "MoviesViewController.\(source).emptyStateText".localized
    }

    private var source: String {
        return presenter.source == .favourites ? "favourites" : "watchlist"
    }

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.getContent()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let deailsViewController = segue.destination as? DetailsViewController, let id = sender as? String {
            deailsViewController.presenter.id = id
        }
    }

    // MARK: - Setup

    override func setupViews() {
        super.setupViews()

        title = "MoviesViewController.\(source).title".localized

        tableView.registerNibForCell(MovieTableViewCell.self)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }

    // MARK: - DataSource

    override func userDidSelectItem(_ item: Movie) {
        super.userDidSelectItem(item)

        present(.Details, with: item.id)
    }

    // MARK: - MoviesViewProtocol

    func populate(with movies: [Movie]) {
        dataSource.populate(with: movies)
        tableView.reloadData()
    }
}
