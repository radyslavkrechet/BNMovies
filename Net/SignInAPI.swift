//
//  SignInAPI.swift
//  Net
//
//  Created by Radyslav Krechet on 02.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Data
import Alamofire

protocol SignInAPIProtocol: class {
    func createToken(handler: @escaping Handler<String>)
    func validate(requestToken: String, username: String, password: String, handler: @escaping Handler<String>)
    func createSession(with requestToken: String, handler: @escaping Handler<Session>)
}

class SignInAPI: SignInAPIProtocol {
    private let networkManager: NetworkManagerProtocol
    private let coderService: CoderServiceProtocol
    private let sessionAdapter: SessionAdapterProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager(),
         coderService: CoderServiceProtocol = CoderService(),
         sessionAdapter: SessionAdapterProtocol = SessionAdapter()) {

        self.networkManager = networkManager
        self.coderService = coderService
        self.sessionAdapter = sessionAdapter
    }

    func createToken(handler: @escaping Handler<String>) {
        let request = AuthRouter.createToken
        networkManager.execute(request) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let json):
                do {
                    let response: CreateValidateTokenResponse = try self.coderService.decode(json)
                    handler(.success(response.requestToken))
                } catch {
                    handler(.failure(error))
                }
            }
        }
    }

    func validate(requestToken: String, username: String, password: String, handler: @escaping Handler<String>) {
        let body = ValidateTokenRequest(username: username, password: password, requestToken: requestToken)
        var parameters: Parameters!

        do {
            parameters = try self.coderService.encode(body)
        } catch {
            handler(.failure(error))
            return
        }

        let request = AuthRouter.validateToken(parameters: parameters)
        networkManager.execute(request) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let json):
                do {
                    let response: CreateValidateTokenResponse = try self.coderService.decode(json)
                    handler(.success(response.requestToken))
                } catch {
                    handler(.failure(error))
                }
            }
        }
    }

    func createSession(with requestToken: String, handler: @escaping Handler<Session>) {
        let body = CreateSessionRequest(requestToken: requestToken)
        var parameters: Parameters!

        do {
            parameters = try self.coderService.encode(body)
        } catch {
            handler(.failure(error))
            return
        }

        let request = AuthRouter.createSession(parameters: parameters)
        networkManager.execute(request) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let json):
                do {
                    let response: CreateSessionResponse = try self.coderService.decode(json)
                    let session = self.sessionAdapter.toEntity(response)
                    handler(.success(session))
                } catch {
                    handler(.failure(error))
                }
            }
        }
    }
}
