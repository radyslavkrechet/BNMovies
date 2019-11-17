//
//  MovieTableViewCell.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/29/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    @IBOutlet private(set) weak var posterImageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var overviewLabel: UILabel!
    @IBOutlet private(set) weak var userScoreLabel: UserScoreLabel!

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()

        posterImageView.kf.cancelDownloadTask()
    }

    // MARK: - Setup

    func populate(with movie: Movie) {
        let posterUrl = URL(string: movie.posterSource)
        posterImageView.kf.setImage(with: posterUrl, placeholder: movie.posterPlaceholder)

        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        userScoreLabel.populate(with: movie.userScore)
    }
}
