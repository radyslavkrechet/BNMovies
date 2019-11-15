//
//  UserRepository.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain

class UserRepository: UserRepositoryProtocol {
    private let userAPI: UserAPIProtocol
    private let userDAO: UserDAOProtocol

    init(userAPI: UserAPIProtocol, userDAO: UserDAOProtocol) {
        self.userAPI = userAPI
        self.userDAO = userDAO
    }

    func getUser(with token: String, handler: @escaping Handler<User>) {
        userDAO.getUser { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let user):
                if let user = user {
                    handler(.success(user))
                }
                self.userAPI.getUser(with: token) { result in
                    switch result {
                    case .failure: handler(result)
                    case .success(let user): self.userDAO.set(user, handler: handler)
                    }
                }
            }
        }
    }

    func deleteUser(handler: @escaping Handler<Void>) {
        userDAO.deleteUser(handler: handler)
    }
}
