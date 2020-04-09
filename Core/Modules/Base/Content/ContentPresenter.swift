//
//  ContentPresenterProtocol.swift
//  Core
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol ContentPresenterProtocol: PresenterProtocol {
    func getContent()
    func tryAgain()
}
