//
//  SplashViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

class SplashViewController<Presenter: SplashPresenterProtocol>: ContentViewController<Presenter>, SplashViewProtocol {

    // MARK: - SplashViewProtocol

    func navigate(_ isSignedIn: Bool) {
        UIStoryboard.set(isSignedIn ? .Main : .SignIn)
    }
}
