//
//  DataStack+CompletionOnGlobal.swift
//  Database
//
//  Created by Radyslav Krechet on 9/10/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import CoreStore

extension DataStack {
    func perform<T>(asynchronous task: @escaping (_ transaction: AsynchronousDataTransaction) throws -> T,
                    completionOnGlobal completion: @escaping (AsynchronousDataTransaction.Result<T>) -> Void) {

        self.perform(asynchronous: task, completion: { result in
            DispatchQueue.global(qos: .userInitiated).async {
                completion(result)
            }
        })
    }
}
