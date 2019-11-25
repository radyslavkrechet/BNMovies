//
//  Workable.swift
//  Domain
//
//  Created by Radyslav Krechet on 25.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

protocol Workable: Executable {
    func work()
}

extension Workable {
    public func execute() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.work()
        }
    }
}
