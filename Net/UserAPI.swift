//
//  UserAPI.swift
//  Net
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain
import Data
import Foundation

class UserAPI: UserAPIProtocol {
    private let networkManager: NetworkManagerProtocol
    private let coderService: CoderServiceProtocol
    private let userAdapter: UserAdapterProtocol

    init(networkManager: NetworkManagerProtocol,
         coderService: CoderServiceProtocol,
         userAdapter: UserAdapterProtocol) {

        self.networkManager = networkManager
        self.coderService = coderService
        self.userAdapter = userAdapter
    }

    func getUser(with token: String, handler: @escaping Handler<User>) {
        let request = UserRouter.getUser(token: token)
        networkManager.execute(request) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let json):
                do {
                    let response: GetUserResponse = try self.coderService.decode(json)
                    let user = self.userAdapter.toObject(response)
                    handler(.success(user))
                } catch {
                    handler(.failure(error))
                }
            }
        }
    }
}
