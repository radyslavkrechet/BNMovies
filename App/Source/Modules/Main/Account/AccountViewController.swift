//
//  AccountViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Kingfisher

class AccountViewController: ContentViewController<AccountViewModel> {
    @IBOutlet private(set) weak var avatarImageView: UIImageView!
    @IBOutlet private(set) weak var usernameLabel: UILabel!

    // MARK: - Setup

    override func setupBinding() {
        super.setupBinding()

        navigationItem.rightBarButtonItem?.rx.tap
            .bind(to: viewModel.signOutDidTap)
            .disposed(by: disposeBag)

        viewModel.user.distinctUntilChanged().subscribe(onNext: { [weak self] user in
            self?.process(user)
        }).disposed(by: disposeBag)

        viewModel.userDidSignOut.subscribe(onNext: { [weak self] _ in
            self?.userDidSignOut()
        }).disposed(by: disposeBag)

        viewModel.signOutError.subscribe(onNext: { [weak self] error in
            self?.presentErrorAlert(with: error.localizedDescription)
        }).disposed(by: disposeBag)
    }

    private func process(_ user: User) {
        let avatarUrl = URL(string: user.avatarSource)
        avatarImageView.kf.setImage(with: avatarUrl, placeholder: user.avatarPlaceholder)
        usernameLabel.text = user.nameToDisplay
    }

    private func userDidSignOut() {
        analyticsManager?.logSignOut()

        UIStoryboard.set(.SignIn)
    }
}
