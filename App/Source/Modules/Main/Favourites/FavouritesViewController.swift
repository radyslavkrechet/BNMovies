//
//  FavouritesViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import UIKit

class FavouritesViewController: ListViewController<FavouritesViewModel, MoviesTableProvider> {
    @IBOutlet private(set) weak var tableView: UITableView!

    override var emptyStateText: String {
        return "FavouritesViewController.emptyStateText".localized
    }

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.getContent()
    }

    // MARK: - Setup

    override func setupViews() {
        super.setupViews()

        tableView.registerNibForCell(MovieTableViewCell.self)
        tableView.dataSource = recyclerProvider
        tableView.delegate = recyclerProvider
    }

    override func setupBinding() {
        super.setupBinding()

        viewModel.movies.distinctUntilChanged().subscribe(onNext: { [weak self] movies in
            self?.process(movies)
        }).disposed(by: disposeBag)
    }

    private func process(_ movies: [Movie]) {
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
