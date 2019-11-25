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

class AccountViewController<Presenter: AccountPresenterProtocol>: ContentViewController<Presenter>,
    AccountViewProtocol {

    @IBOutlet private(set) weak var avatarImageView: UIImageView!
    @IBOutlet private(set) weak var usernameLabel: UILabel!

    // MARK: - Actions

    @IBAction private func signOutButtonDidTap(_ sender: UIBarButtonItem) {
        presenter.signOut()
    }

    // MARK: - AccountViewProtocol

    func populate(with user: User) {
        let avatarUrl = URL(string: user.avatarSource)
        avatarImageView.kf.setImage(with: avatarUrl, placeholder: user.avatarPlaceholder)
        usernameLabel.text = user.nameToDisplay
    }

    func presentSignOutError(_ error: Error) {
        presentErrorAlert(with: error.localizedDescription)
    }

    func userDidSignOut() {
        analyticsManager?.logSignOut()
        UIStoryboard.set(.SignIn)
    }
}
