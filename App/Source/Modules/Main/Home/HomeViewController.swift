//
//  HomeViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import UIKit

class HomeViewController: PaginationViewController<HomeViewModel, MoviesTableProvider> {
    @IBOutlet private(set) weak var tableView: UITableView!

    // MARK: - Setup

    override func setupViews() {
        super.setupViews()

        tableView.registerNibForCell(MovieTableViewCell.self)
        tableView.refreshControl = refreshControl
        tableView.dataSource = recyclerProvider
        tableView.delegate = recyclerProvider
    }

    override func setupBinding() {
        super.setupBinding()

        viewModel.movies.subscribe(onNext: { [weak self] movies in
            self?.process(movies)
        }).disposed(by: disposeBag)
    }

    private func process(_ movies: [Movie]) {
        refreshControl.endRefreshing()
        recyclerProvider.items.value = movies
        tableView.reloadData()
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
