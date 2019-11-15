//
//  CoreStore+CompletionOnGlobal.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/10/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import CoreStore

extension CoreStore {
    static func perform<T>(asynchronous task: @escaping (_ transaction: AsynchronousDataTransaction) throws -> T,
                           completionOnGlobal completion: @escaping (AsynchronousDataTransaction.Result<T>) -> Void) {

        self.defaultStack.perform(asynchronous: task) { result in
            DispatchQueue.global(qos: .userInitiated).async {
                completion(result)
            }
        }
    }
}
