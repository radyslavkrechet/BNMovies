//
//  PaddingLabel.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/4/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

@IBDesignable class PaddingLabel: UILabel {
    var insets = UIEdgeInsets.zero {
        didSet {
            setNeedsLayout()
            invalidateIntrinsicContentSize()
        }
    }

    @IBInspectable var topInset: CGFloat {
        get { return insets.top }
        set { insets.top = newValue }
    }
    @IBInspectable var bottomInset: CGFloat {
        get { return insets.bottom }
        set { insets.bottom = newValue }
    }
    @IBInspectable var leftInset: CGFloat {
        get { return insets.left }
        set { insets.left = newValue }
    }
    @IBInspectable var rightInset: CGFloat {
        get { return insets.right }
        set { insets.right = newValue }
    }

    override var intrinsicContentSize: CGSize {
        return sizeWithInsets(super.intrinsicContentSize)
    }

    // MARK: - Lifecycle

    override func drawText(in rect: CGRect) {
        let adjustedRect = rect.inset(by: insets)
        super.drawText(in: adjustedRect)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let sizeThatFits = super.sizeThatFits(size)
        return sizeWithInsets(sizeThatFits)
    }

    private func sizeWithInsets(_ size: CGSize) -> CGSize {
        let width = size.width + leftInset + rightInset
        let height = size.height + topInset + bottomInset
        return CGSize(width: width, height: height)
    }
}
