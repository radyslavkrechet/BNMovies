//
//  UserDetailsTableViewCell.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 10.01.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain
import Kingfisher

class UserDetailsTableViewCell: UITableViewCell {
    @IBOutlet private(set) weak var avatarImageView: UIImageView!
    @IBOutlet private(set) weak var usernameLabel: UILabel!

    // MARK: - Setup

    func populate(with user: User) {
        let avatarUrl = URL(string: user.avatarSource)
        avatarImageView.kf.setImage(with: avatarUrl, placeholder: user.avatarPlaceholder)
        usernameLabel.text = user.nameToDisplay
    }
}
