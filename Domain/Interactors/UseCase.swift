//
//  UseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 9/10/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public class UseCase<Result> {
    public func execute(handler: @escaping Handler<Result>) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.work(handler: handler)
        }
    }

    func work(handler: @escaping Handler<Result>) {}
}
