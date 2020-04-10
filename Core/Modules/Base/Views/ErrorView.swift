//
//  ErrorView.swift
//  Core
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import UIKit

protocol ErrorViewDelegate: class {
    func tryAgainButtonDidTap()
}

class ErrorView: View {
    @IBOutlet private(set) weak var textLabel: UILabel!

    weak var delegate: ErrorViewDelegate?

    // MARK: - Actions

    @IBAction private func tryAgainButtonDidTap(_ sender: UIButton) {
        delegate?.tryAgainButtonDidTap()
    }
}
