//
//  GenreEntity.swift
//  Database
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import CoreStore

class GenreEntity: CoreStoreObject {
    let id = Value.Required<String>("id", initial: "")
    let name = Value.Required<String>("name", initial: "")
}
