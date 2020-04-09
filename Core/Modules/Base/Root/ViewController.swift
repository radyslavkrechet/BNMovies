//
//  ViewController.swift
//  Core
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import UIKit

public protocol ViewProtocol: class {}

open class ViewController<Presenter: PresenterProtocol>: UIViewController, ViewProtocol {
    public var presenter: Presenter!

    // MARK: - Lifecycle

    open override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Setup

    open func setupViews() {}
}
