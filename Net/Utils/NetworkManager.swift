//
//  NetworkManager.swift
//  Net
//
//  Created by Radyslav Krechet on 9/4/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Alamofire

protocol NetworkManagerProtocol {
    func execute(_ request: URLRequestConvertible, handler: @escaping Handler<Any>)
}

struct NetworkManager: NetworkManagerProtocol {
    func execute(_ request: URLRequestConvertible, handler: @escaping Handler<Any>) {
        let queue = DispatchQueue.global(qos: .userInitiated)
        Alamofire.request(request).validate().responseJSON(queue: queue) { response in
            switch response.result {
            case .failure(let error): handler(.failure(error))
            case .success(let json): handler(.success(json))
            }
        }
    }
}
