//
//  User+Displaying.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import UIKit

extension User {
    var nameToDisplay: String {
        return name ?? username
    }
    var avatarPlaceholder: UIImage? {
        return "Avatar".image
    }
}
