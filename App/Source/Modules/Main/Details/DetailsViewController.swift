//
//  DetailsViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Kingfisher

protocol DetailsViewProtocol: ContentViewProtocol {
    func populate(with movie: Movie)
    func populate(with favouriteTitle: String)
    func presentFavouriteError(_ error: Error)
}

class DetailsViewController: ContentViewController<DetailsPresenter>, DetailsViewProtocol {
    @IBOutlet private(set) weak var backdropImageView: UIImageView!
    @IBOutlet private(set) weak var posterImageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var genresLabel: UILabel!
    @IBOutlet private(set) weak var runtimeLabel: UILabel!
    @IBOutlet private(set) weak var releaseDateLabel: UILabel!
    @IBOutlet private(set) weak var userScoreLabel: UserScoreLabel!
    @IBOutlet private(set) weak var overviewLabel: UILabel!

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.getContent()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let similarMoviesViewController = segue.destination as? SimilarMoviesViewController {
            similarMoviesViewController.presenter.id = presenter.id
        }
    }

    // MARK: - Actions

    @IBAction private func favouriteButtonDidTap(_ sender: UIBarButtonItem) {
        presenter.markMovieAsFavourite()

        if let title = navigationItem.rightBarButtonItem?.title {
            analyticsManager?.logClick(in: self.nameOfClass, senderTitle: title)
        }
    }

    // MARK: - DetailsViewProtocol

    func populate(with movie: Movie) {
        let backdropUrl = URL(string: movie.backdropSource)
        backdropImageView.kf.setImage(with: backdropUrl, placeholder: movie.backdropPlaceholder)

        let posterUrl = URL(string: movie.posterSource)
        posterImageView.kf.setImage(with: posterUrl, placeholder: movie.posterPlaceholder)

        titleLabel.text = movie.title
        genresLabel.text = movie.genresToDisplay
        runtimeLabel.text = movie.runtimeToDisplay
        releaseDateLabel.text = movie.releaseDateToDisplay
        userScoreLabel.populate(with: movie.userScore)
        overviewLabel.text = movie.overview
    }

    func populate(with favouriteTitle: String) {
        guard let button = navigationItem.rightBarButtonItem else { return }
        button.title = favouriteTitle
    }

    func presentFavouriteError(_ error: Error) {
        presentErrorAlert(with: error.localizedDescription)
    }
}
