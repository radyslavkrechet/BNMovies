//
//  TagLabel.swift
//  Movies
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

private let topBottomInset: CGFloat = 2
private let leftRightInset: CGFloat = 4
private let tagCornerRadius: CGFloat = 4

class TagLabel: PaddingLabel {

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        insets = UIEdgeInsets(top: topBottomInset, left: leftRightInset, bottom: topBottomInset, right: leftRightInset)
        cornerRadius = tagCornerRadius
    }
}
