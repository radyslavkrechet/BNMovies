//
//  SplashViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import UIKit

class SplashViewController: ContentViewController<SplashViewModel> {

    // MARK: - Setup

    override func setupBinding() {
        super.setupBinding()

        viewModel.isSignedIn.subscribe(onNext: { isSignedIn in
            UIStoryboard.set(isSignedIn ? .Main : .SignIn)
        }).disposed(by: disposeBag)
    }
}
