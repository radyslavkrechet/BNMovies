//
//  DetailsViewController.swift
//  Movies
//
//  Created by Radyslav Krechet on 10.04.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Core
import Domain
import Kingfisher

protocol DetailsViewProtocol: ContentViewProtocol {
    func populate(with movie: Movie)
}

class DetailsViewController: ContentViewController<DetailsPresenter>, DetailsViewProtocol {
    @IBOutlet private(set) weak var backdropImageView: UIImageView!
    @IBOutlet private(set) weak var posterImageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var infoLabel: UILabel!
    @IBOutlet private(set) weak var overviewLabel: UILabel!

    // MARK: - DetailsViewProtocol

    func populate(with movie: Movie) {
        let backdropUrl = URL(string: movie.backdropSource)
        backdropImageView.kf.setImage(with: backdropUrl)

        let posterUrl = URL(string: movie.posterSource)
        posterImageView.kf.setImage(with: posterUrl)

        titleLabel.text = movie.title
        infoLabel.text = "\(movie.genresToDisplay)\n\(movie.runtimeToDisplay)\n\(movie.releaseDateToDisplay)"
        overviewLabel.text = movie.overview
    }
}
