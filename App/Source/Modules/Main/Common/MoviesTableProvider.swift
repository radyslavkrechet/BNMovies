//
//  MoviesTableProvider.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/29/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import RxSwift

class MoviesTableProvider: NSObject, PaginationTableProviderProtocol {
    let items = Variable<[Movie]>([])

    private(set) lazy var userDidSelectItem: Observable<Movie> = userDidSelectItemSubject.observeOnMain()
    private(set) lazy var lastItemWillDisplay: Observable<Void> = lastItemWillDisplaySubject.observeOnMain()

    private let userDidSelectItemSubject = PublishSubject<Movie>()
    private let lastItemWillDisplaySubject = PublishSubject<Void>()

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = items.value[indexPath.row]
        let cell: MovieTableViewCell = tableView.dequeueReusableCellForIndexPath(indexPath)
        cell.populate(with: movie)
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let movie = items.value[indexPath.row]
        userDidSelectItemSubject.onNext(movie)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == items.value.count - 1 {
            lastItemWillDisplaySubject.onNext(())
        }
    }
}
