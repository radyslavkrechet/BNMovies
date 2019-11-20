//
//  ContentViewProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 17.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

protocol ContentViewProtocol: ViewProtocol {
    func populate(with state: ContentState)
}
