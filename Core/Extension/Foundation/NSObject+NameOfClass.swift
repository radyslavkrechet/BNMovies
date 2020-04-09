//
//  NSObject+NameOfClass.swift
//  Core
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

public extension NSObject {
    class var nameOfClass: String {
        return String(describing: self)
    }
    var nameOfClass: String {
        return String(describing: type(of: self))
    }
}
