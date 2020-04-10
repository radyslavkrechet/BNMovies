//
//  ViewController.swift
//  Core
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import UIKit

public protocol ContentViewProtocol: ViewProtocol {
    func populate(with state: ContentState)
}

open class ContentViewController<Presenter: ContentPresenterProtocol>: ViewController<Presenter>, ContentViewProtocol,
    ErrorViewDelegate {

    open var emptyStateText: String {
        return ""
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

    open override func viewDidLoad() {
        super.viewDidLoad()

        presenter.getContent()
    }

    // MARK: - ContentViewProtocol

    public func populate(with state: ContentState) {
        stateView?.removeFromSuperview()

        switch state {
        case .loading:
            let loadingView = LoadingView()
            stateView = loadingView
        case .empty:
            let emptyView = EmptyView()
            emptyView.textLabel.text = emptyStateText
            stateView = emptyView
        case .content:
            stateView = nil
        case .error(let error):
            let errorView = ErrorView()
            errorView.textLabel.text = error.localizedDescription
            errorView.delegate = self
            stateView = errorView
        }
    }

    // MARK: - ErrorViewDelegate

    func tryAgainButtonDidTap() {
        presenter.tryAgain()
    }
}
