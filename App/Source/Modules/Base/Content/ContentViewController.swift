//
//  ViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

protocol ContentViewProtocol: ViewProtocol {
    func populate(with state: ContentState)
}

class ContentViewController<Presenter: ContentPresenterProtocol>: ViewController<Presenter>, ContentViewProtocol,
    ErrorViewDelegate {

    var loadingStateText: String? {
        return nil
    }
    var emptyStateText: String {
        return ""
    }
    var emptyStateImage: UIImage? {
        return nil
    }
    var errorStateImage: UIImage? {
        return nil
    }

    private var stateView: UIView? {
        didSet {
            if let stateView = stateView {
                view.addSubview(stateView)
                view.addConstraints(to: stateView)
            }
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.getContent()
    }

    // MARK: - ContentViewProtocol

    func populate(with state: ContentState) {
        stateView?.removeFromSuperview()

        switch state {
        case .loading:
            let loadingView = LoadingView()
            loadingView.populate(with: loadingStateText)
            stateView = loadingView
        case .empty:
            let emptyView = EmptyView()
            emptyView.populate(with: emptyStateText, image: emptyStateImage)
            stateView = emptyView
        case .content:
            stateView = nil
        case .error(let error):
            let errorView = ErrorView()
            errorView.populate(with: error.localizedDescription, image: errorStateImage)
            errorView.delegate = self
            stateView = errorView
        }
    }

    // MARK: - ErrorViewDelegate

    func tryAgainButtonDidTap() {
        presenter.tryAgain()
    }
}
