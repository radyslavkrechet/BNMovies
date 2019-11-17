//
//  DetailsViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Kingfisher

class DetailsViewController: ContentViewController<DetailsViewModel> {
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

        viewModel.getContent()
    }

    // MARK: - Setup

    override func setupBinding() {
        super.setupBinding()

        navigationItem.rightBarButtonItem?.rx.tap
            .do(onNext: { [weak self] _ in
                self?.favouriteDidTap()
            })
            .bind(to: viewModel.favouriteDidTap)
            .disposed(by: disposeBag)

        viewModel.movie.distinctUntilChanged().subscribe(onNext: { [weak self] movie in
            self?.process(movie)
        }).disposed(by: disposeBag)

        if let rightBarButtonItem = navigationItem.rightBarButtonItem {
            viewModel.favouriteTitle
                .bind(to: rightBarButtonItem.rx.title)
                .disposed(by: disposeBag)
        }

        viewModel.favouriteError.subscribe(onNext: { [weak self] error in
            self?.presentErrorAlert(with: error.localizedDescription)
        }).disposed(by: disposeBag)
    }

    private func favouriteDidTap() {
        if let title = navigationItem.rightBarButtonItem?.title {
            analyticsManager?.logClick(in: self.nameOfClass, senderTitle: title)
        }
    }

    private func process(_ movie: Movie) {
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

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let similarMoviesViewController = segue.destination as? SimilarMoviesViewController {
            similarMoviesViewController.viewModel.id = viewModel.id
        }
    }
}
