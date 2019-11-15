//
//  ScoreView.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import UIKit

private enum ScoreColor: String {
    case Great, Good, Bad, None
}

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
        case 0:
            name = ScoreColor.None.rawValue
        case 1..<40:
            name = ScoreColor.Bad.rawValue
        case 40..<70:
            name = ScoreColor.Good.rawValue
        default:
            name = ScoreColor.Great.rawValue
        }
        backgroundColor = UIColor(named: name)
    }
}
