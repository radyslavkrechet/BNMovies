//
//  ValidateTokenRequest.swift
//  Net
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

struct ValidateTokenRequest: Encodable {
    let username: String
    let password: String
    let requestToken: String
}
