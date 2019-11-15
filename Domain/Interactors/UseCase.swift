//
//  UseCase.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/10/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

public class UseCase<S> {
    public func execute(handler: @escaping Handler<S>) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.work(handler: handler)
        }
    }

    func work(handler: @escaping Handler<S>) {}
}
