//
//  DataStack+CompletionOnGlobal.swift
//  Database
//
//  Created by Radyslav Krechet on 9/10/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import CoreStore

extension DataStack {
    func perform<Task>(asynchronous task: @escaping (_ transaction: AsynchronousDataTransaction) throws -> Task,
                       completionOnGlobal completion: @escaping (AsynchronousDataTransaction.Result<Task>) -> Void) {

        self.perform(asynchronous: task, completion: { result in
            DispatchQueue.global(qos: .userInitiated).async {
                completion(result)
            }
        })
    }
}
