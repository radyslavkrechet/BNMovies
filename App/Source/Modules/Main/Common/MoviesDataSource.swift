//
//  MoviesDataSource.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/29/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol MoviesDataSourceProtocol: PaginationTableDataSourceProtocol where Item == Movie {}

class MoviesDataSource: NSObject, MoviesDataSourceProtocol {
    var userDidSelectItem: ((Movie) -> Void)?
    var lastItemWillDisplay: (() -> Void)?

    private var items = [Movie]()

    func populate(with items: [Movie]) {
        self.items = items
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = items[indexPath.row]
        let cell: MovieTableViewCell = tableView.dequeueReusableCellForIndexPath(indexPath)
        cell.populate(with: movie)
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let movie = items[indexPath.row]
        userDidSelectItem?(movie)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == items.count - 1 {
            lastItemWillDisplay?()
        }
    }
}
