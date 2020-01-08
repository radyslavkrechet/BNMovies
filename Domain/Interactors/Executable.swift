//
//  Executable.swift
//  Domain
//
//  Created by Radyslav Krechet on 9/10/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

protocol Executable: class {
    var work: () -> Void { get }
    func execute()
}

extension Executable {
    func execute() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.work()
        }
    }
}
