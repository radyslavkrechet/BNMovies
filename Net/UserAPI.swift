//
//  UserAPI.swift
//  Net
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Data
import Foundation

class UserAPI: UserAPIProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }

    func getUser(with token: String, handler: @escaping Handler<User>) {
        let request = UserRouter.getUser(token: token)
        networkManager.execute(request) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let json):
                do {
                    let response: GetUserResponse = try CoderService.decode(json)
                    let user = UserAdapter.toEntity(response)
                    handler(.success(user))
                } catch {
                    handler(.failure(error))
                }
            }
        }
    }
}
