//
//  SplashViewController.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import UIKit
import Core

protocol SplashViewProtocol: ContentViewProtocol {
    func navigate(_ isSignedIn: Bool)
}

class SplashViewController: ContentViewController<SplashPresenter>, SplashViewProtocol {

    // MARK: - SplashViewProtocol

    func navigate(_ isSignedIn: Bool) {
        UIStoryboard.set(isSignedIn ? .Main : .SignIn)
    }
}
