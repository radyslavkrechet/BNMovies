//
//  ErrorView.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

class ErrorView: View {
    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet private(set) weak var textLabel: UILabel!
    @IBOutlet private(set) weak var tryAgainButton: UIButton!

    // MARK: - Setup

    func populate(with text: String, image: UIImage? = nil) {
        textLabel.text = text
        imageView.isHidden = image == nil
        imageView.image = image
    }
}
