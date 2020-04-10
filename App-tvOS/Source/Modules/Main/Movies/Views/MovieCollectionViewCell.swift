//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Radyslav Krechet on 10.04.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet private(set) weak var posterImageView: UIImageView!

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()

        posterImageView.kf.cancelDownloadTask()
    }

    // MARK: - Setup

    func populate(with movie: Movie) {
        let posterUrl = URL(string: movie.posterSource)
        posterImageView.kf.setImage(with: posterUrl)
    }
}
