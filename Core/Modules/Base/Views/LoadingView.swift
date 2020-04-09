//
//  LoadingView.swift
//  Core
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import UIKit

class LoadingView: View {
    @IBOutlet private(set) weak var textLabel: UILabel!
    @IBOutlet private(set) weak var activityIndicatorView: UIActivityIndicatorView!

    // MARK: - Setup

    func populate(with text: String? = nil) {
        textLabel.isHidden = text == nil
        textLabel.text = text
    }
}
