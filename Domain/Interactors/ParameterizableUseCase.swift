//
//  ParameterizableUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 9/10/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public class ParameterizableUseCase<R, P>: UseCase<R> {
    public var parameters: P!

    public override func execute(handler: @escaping Handler<R>) {
        guard parameters != nil else {
            preconditionFailure("Failed to execute use case without parameters")
        }

        super.execute(handler: handler)
    }
}
