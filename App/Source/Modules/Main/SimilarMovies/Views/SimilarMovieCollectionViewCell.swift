//
//  SimilarMovieCollectionViewCell.swift
//  Movies
//
//  Created by Radyslav Krechet on 9/6/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import UIKit

class SimilarMovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet private(set) weak var backdropImageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var userScoreLabel: UserScoreLabel!

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()

        backdropImageView.kf.cancelDownloadTask()
    }

    // MARK: - Setup

    func populate(with movie: Movie) {
        let backdropUrl = URL(string: movie.backdropSource)
        backdropImageView.kf.setImage(with: backdropUrl, placeholder: movie.backdropPlaceholder)

        titleLabel.text = movie.title
        userScoreLabel.populate(with: movie.userScore)
    }
}
