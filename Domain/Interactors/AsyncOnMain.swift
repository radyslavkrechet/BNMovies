//
//  AsyncOnMain.swift
//  Domain
//
//  Created by Radyslav Krechet on 08.01.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

@propertyWrapper
struct AsyncOnMain<Success> {
    var wrappedValue: Handler<Success>! {
        get { return handler }
        set {
            handler = { result in
                DispatchQueue.main.async {
                    newValue(result)
                }
            }
        }
    }

    private var handler: Handler<Success>!
}
