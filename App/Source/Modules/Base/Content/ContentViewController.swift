//
//  ViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

class ContentViewController<V: ContentViewModelProtocol>: ViewController<V> {
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

        viewModel.getContent()
    }

    // MARK: - Setup

    override func setupBinding() {
        super.setupBinding()

        viewModel.state.distinctUntilChanged().subscribe(onNext: { [weak self] state in
            self?.process(state)
        }).disposed(by: disposeBag)
    }

    private func process(_ state: ContentState) {
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

            errorView.tryAgainButton.rx.tap.subscribe(onNext: { [weak self] _ in
                self?.viewModel.tryAgain()
            }).disposed(by: errorView.disposeBag)

            stateView = errorView
        }
    }
}
