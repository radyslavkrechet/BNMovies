//
//  UseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 9/10/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public class UseCase<R> {
    public func execute(handler: @escaping Handler<R>) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.work(handler: handler)
        }
    }

    func work(handler: @escaping Handler<R>) {}
}
