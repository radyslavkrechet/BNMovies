//
//  GetUserResponse.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

struct GetUserResponse: Decodable {
    let id: Int
    let username: String
    let name: String?
    let avatar: AvatarResponse
}

struct AvatarResponse: Decodable {
    let gravatar: GravatarResponse
}

struct GravatarResponse: Decodable {
    let hash: String
}
