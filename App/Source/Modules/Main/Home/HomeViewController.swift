//
//  HomeViewController.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol HomeViewProtocol: PaginationViewProtocol {
    func populate(with movies: [Movie])
}

class HomeViewController: PaginationViewController<HomePresenter, MoviesDataSource>, HomeViewProtocol {
    @IBOutlet private(set) weak var tableView: UITableView!

    private var isNeedToScrollToTop = false

    // MARK: - Lifecycle

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let deailsViewController = segue.destination as? DetailsViewController, let id = sender as? String {
            deailsViewController.presenter.id = id
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

    @IBAction func chartSegmentedControlValueDidChange(_ sender: UISegmentedControl) {
        if let chart = Movie.Chart(rawValue: sender.selectedSegmentIndex) {
            isNeedToScrollToTop = true
            presenter.changeChart(chart)
        }
    }

    // MARK: - DataSource

    override func userDidSelectItem(_ item: Movie) {
        super.userDidSelectItem(item)

        present(.Details, with: item.id)
    }

    // MARK: - HomeViewProtocol

    func populate(with movies: [Movie]) {
        refreshControl.endRefreshing()
        dataSource.populate(with: movies)
        tableView.reloadData()

        if isNeedToScrollToTop {
            isNeedToScrollToTop.toggle()

            let indexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}
