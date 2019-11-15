//
//  ParameterizableUseCase.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/10/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

public class ParameterizableUseCase<S, P>: UseCase<S> {
    public var parameters: P!

    public override func execute(handler: @escaping Handler<S>) {
        guard parameters != nil else {
            preconditionFailure("Failed to execute use case without parameters")
        }

        super.execute(handler: handler)
    }
}
