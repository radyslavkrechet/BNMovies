//
//  UIViewController+Alert.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentErrorAlert(with message: String) {
        let okAction = UIAlertAction(title: "UIViewController.alert.ok".localized, style: .default)
        let alertViewController = UIAlertController(title: "UIViewController.alert.title".localized,
                                                    message: message,
                                                    preferredStyle: .alert)

        alertViewController.addAction(okAction)
        present(alertViewController, animated: true)
    }
}
