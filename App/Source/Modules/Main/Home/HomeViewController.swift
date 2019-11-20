//
//  HomeViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import UIKit

class HomeViewController<Presenter: HomePresenterProtocol,
    DataSource: MoviesDataSourceProtocol>: PaginationViewController<Presenter, DataSource>, HomeViewProtocol {

    @IBOutlet private(set) weak var tableView: UITableView!

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

        tableView.registerNibForCell(MovieTableViewCell.self)
        tableView.refreshControl = refreshControl
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }

    // MARK: - DataSource

    override func userDidSelectItem(_ item: Movie) {
        super.userDidSelectItem(item)

        present(.Details, with: item)
    }

    // MARK: - HomeViewProtocol

    func populate(with movies: [Movie]) {
        refreshControl.endRefreshing()
        dataSource.populate(with: movies)
        tableView.reloadData()
    }
}
