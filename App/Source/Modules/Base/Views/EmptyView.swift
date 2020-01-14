//
//  EmptyView.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

class EmptyView: View {
    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet private(set) weak var textLabel: UILabel!

    // MARK: - Setup

    func populate(with text: String, image: UIImage? = nil) {
        textLabel.text = text
        imageView.isHidden = image == nil
        imageView.image = image
    }
}
