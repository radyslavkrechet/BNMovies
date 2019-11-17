//
//  ViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import RxSwift

class ViewController<V: ViewModelProtocol>: UIViewController {
    let disposeBag = DisposeBag()
    var viewModel: V!
    var analyticsManager: AnalyticsManagerProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupBinding()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        analyticsManager?.logPresentation(of: self.nameOfClass)
    }

    // MARK: - Setup

    func setupViews() {}

    func setupBinding() {}
}
