//
//  DetailsViewController.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Core
import Domain
import Kingfisher

protocol DetailsViewProtocol: ContentViewProtocol {
    func populate(with movie: Movie)
    func presentMarkError(_ error: Error)
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
    @IBOutlet private(set) weak var favouriteButton: UIBarButtonItem!
    @IBOutlet private(set) weak var watchlistButton: UIBarButtonItem!

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

    @IBAction private func shareButtonDidTap(_ sender: UIBarButtonItem) {
        let activityItems = [presenter.shareURL]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(activityViewController, animated: true)
    }

    @IBAction private func markButtonDidTap(_ sender: UIBarButtonItem) {
        let collection = Movie.Collection(rawValue: sender.tag)!
        presenter.markMovie(collection)
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

        favouriteButton.image = "heart\(movie.isInFavourites ? ".fill" : "")".systemImage
        watchlistButton.image = "bookmark\(movie.isInWatchlist ? ".fill" : "")".systemImage
    }

    func presentMarkError(_ error: Error) {
        presentErrorAlert(with: error.localizedDescription)
    }
}
