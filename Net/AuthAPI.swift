//
//  AuthAPI.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import Data
import Alamofire

class AuthAPI: AuthAPIProtocol {
    func signIn(with username: String, password: String, handler: @escaping Handler<Session>) {
        createToken { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let requestToken):
                self.validate(requestToken: requestToken, username: username, password: password) { result in
                    switch result {
                    case .failure(let error): handler(.failure(error))
                    case .success(let requestToken): self.createSession(with: requestToken, handler: handler)
                    }
                }
            }
        }
    }

    private func createToken(handler: @escaping Handler<String>) {
        let request = AuthRouter.createToken
        NetworkService.execute(request) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let json):
                do {
                    let response: CreateValidateTokenResponse = try CoderService.decode(json)
                    handler(.success(response.requestToken))
                } catch {
                    handler(.failure(error))
                }
            }
        }
    }

    private func validate(requestToken: String,
                          username: String,
                          password: String,
                          handler: @escaping Handler<String>) {

        let body = ValidateTokenRequest(username: username, password: password, requestToken: requestToken)
        var parameters: Parameters!

        do {
            parameters = try CoderService.encode(body)
        } catch {
            handler(.failure(error))
            return
        }

        let request = AuthRouter.validateToken(parameters: parameters)
        NetworkService.execute(request) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let json):
                do {
                    let response: CreateValidateTokenResponse = try CoderService.decode(json)
                    handler(.success(response.requestToken))
                } catch {
                    handler(.failure(error))
                }
            }
        }
    }

    private func createSession(with requestToken: String, handler: @escaping Handler<Session>) {
        let body = CreateSessionRequest(requestToken: requestToken)
        var parameters: Parameters!

        do {
            parameters = try CoderService.encode(body)
        } catch {
            handler(.failure(error))
            return
        }

        let request = AuthRouter.createSession(parameters: parameters)
        NetworkService.execute(request) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let json):
                do {
                    let response: CreateSessionResponse = try CoderService.decode(json)
                    let session = SessionAdapter.toEntity(response)
                    handler(.success(session))
                } catch {
                    handler(.failure(error))
                }
            }
        }
    }
}
