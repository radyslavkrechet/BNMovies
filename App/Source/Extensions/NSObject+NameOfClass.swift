//
//  NSObject+NameOfClass.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
        return String(describing: self)
    }
    var nameOfClass: String {
        return String(describing: type(of: self))
    }
}
