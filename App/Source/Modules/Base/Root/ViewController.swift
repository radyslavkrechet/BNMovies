//
//  ViewController.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import UIKit

protocol ViewProtocol: class {}

class ViewController<Presenter: PresenterProtocol>: UIViewController, ViewProtocol {
    var presenter: Presenter!
    var analyticsService: AnalyticsServiceProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        analyticsService?.logPresentation(of: self.nameOfClass)
    }

    // MARK: - Setup

    func setupViews() {}
}
