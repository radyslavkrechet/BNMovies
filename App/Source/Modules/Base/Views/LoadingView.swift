//
//  LoadingView.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import UIKit

class LoadingView: View {
    @IBOutlet private(set) weak var textLabel: UILabel!
    @IBOutlet private(set) weak var activityIndicatorView: UIActivityIndicatorView!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        if #available(iOS 13.0, *) {
            activityIndicatorView.style = .medium
        }
    }

    // MARK: - Setup

    func populate(with text: String? = nil) {
        textLabel.isHidden = text == nil
        textLabel.text = text
    }
}
