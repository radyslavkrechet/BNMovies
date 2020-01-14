//
//  ScoreView.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

class UserScoreLabel: TagLabel {

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        textColor = .white
    }

    // MARK: - Setup

    func populate(with score: Int) {
        text = "\(score)%"

        var name = ""
        switch score {
        case 0: name = "Grey"
        case 1..<40: name = "Red"
        case 40..<70: name = "Yellow"
        default: name = "Green"
        }
        backgroundColor = name.color
    }
}
