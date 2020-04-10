//
//  AccountDataSource.swift
//  Movies
//
//  Created by Radyslav Krechet on 10.01.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Core
import Domain
import UIKit

protocol AccountDataSourceProtocol: UITableViewDataSource, UITableViewDelegate {
    var navigate: ((Movie.Collection) -> Void)? { get set }
    var userDidSignOut: (() -> Void)? { get set }

    func populate(with user: User)
}

class AccountDataSource: NSObject, AccountDataSourceProtocol {
    private enum Section: Int, CaseIterable {
        case user, collections, actions
    }

    private enum UserRow: Int, CaseIterable {
        case details
    }

    private enum ActionsRow: Int, CaseIterable {
        case signOut
    }

    private enum RowHeight: CGFloat {
        case `default` = 44
        case extra = 70
    }

    var navigate: ((Movie.Collection) -> Void)?
    var userDidSignOut: (() -> Void)?

    private var user: User?

    func populate(with user: User) {
        self.user = user
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .user: return UserRow.allCases.count
        case .collections: return Movie.Collection.allCases.count
        case .actions: return ActionsRow.allCases.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        switch Section(rawValue: indexPath.section)! {
        case .user:
            switch UserRow(rawValue: indexPath.row)! {
            case .details:
                guard let user = user else { break }

                let cell: UserDetailsTableViewCell = tableView.dequeueReusableCellForIndexPath(indexPath)
                cell.populate(with: user)
                return cell
            }
        case .collections:
            cell.accessoryType = .disclosureIndicator

            switch Movie.Collection(rawValue: indexPath.row)! {
            case .favourites:
                cell.imageView?.image = "heart.fill".systemImage
                cell.textLabel?.text = "AccountViewController.favourites".localized
            case .watchlist:
                cell.imageView?.image = "bookmark.fill".systemImage
                cell.textLabel?.text = "AccountViewController.watchlist".localized
            }
        case .actions:
            switch ActionsRow(rawValue: indexPath.row)! {
            case .signOut:
                cell.textLabel?.text = "AccountViewController.signOut".localized
                cell.textLabel?.textColor = "Red".color
            }
        }

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = RowHeight.default
        if indexPath.section == Section.user.rawValue && indexPath.row == UserRow.details.rawValue {
            height = .extra
        }
        return height.rawValue
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch Section(rawValue: indexPath.section)! {
        case .collections:
            let collection = Movie.Collection(rawValue: indexPath.row)!
            navigate?(collection)
        case .actions:
            switch ActionsRow(rawValue: indexPath.row)! {
            case .signOut: userDidSignOut?()
            }
        default: return
        }
    }
}
