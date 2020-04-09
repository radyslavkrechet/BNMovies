//
//  ContentPresenterProtocol.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

protocol ContentPresenterProtocol: PresenterProtocol {
    func getContent()
    func tryAgain()
}
