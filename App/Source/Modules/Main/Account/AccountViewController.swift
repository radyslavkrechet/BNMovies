//
//  AccountViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Kingfisher

protocol AccountViewProtocol: ContentViewProtocol {
    func populate(with user: User)
    func presentSignOutError(_ error: Error)
    func userDidSignOut()
}

class AccountViewController: ContentViewController<AccountPresenter>, AccountViewProtocol {
    @IBOutlet private(set) weak var tableView: UITableView!

    var dataSource: AccountDataSourceProtocol!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDataSource()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let moviesViewController = segue.destination as? MoviesViewController, let source = sender as? Movie.List {
            moviesViewController.presenter.source = source
        }
    }

    // MARK: - Setup

    override func setupViews() {
        super.setupViews()

        tableView.registerNibForCell(UserDetailsTableViewCell.self)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }

    func setupDataSource() {
        dataSource.navigate = { [weak self] source in
            self?.present(.Movies, with: source)
        }

        dataSource.userDidSignOut = { [weak self] in
            self?.presenter.signOut()
        }
    }

    // MARK: - AccountViewProtocol

    func populate(with user: User) {
        dataSource.populate(with: user)
        tableView.reloadData()
    }

    func presentSignOutError(_ error: Error) {
        presentErrorAlert(with: error.localizedDescription)
    }

    func userDidSignOut() {
        analyticsService?.logSignOut()
        UIStoryboard.set(.SignIn)
    }
}
