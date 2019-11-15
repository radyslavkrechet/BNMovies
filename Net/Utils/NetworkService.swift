//
//  NetworkService.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/4/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import Alamofire
import AlamofireNetworkActivityIndicator

enum NetworkService {
    static func setup() {
        NetworkActivityIndicatorManager.shared.isEnabled = true
        NetworkActivityIndicatorManager.shared.startDelay = 0
    }

    static func execute(_ request: URLRequestConvertible, handler: @escaping Handler<Any>) {
        let queue = DispatchQueue.global(qos: .userInitiated)
        Alamofire.request(request).validate().responseJSON(queue: queue) { response in
            switch response.result {
            case .failure(let error): handler(.failure(error))
            case .success(let json): handler(.success(json))
            }
        }
    }
}
