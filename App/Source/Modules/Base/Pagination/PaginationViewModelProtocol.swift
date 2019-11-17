//
//  PaginationViewModelProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import RxSwift

protocol PaginationViewModelProtocol: ListViewModelProtocol {
    var refreshControlDidPull: AnyObserver<Void> { get }

    func getMoreContent()
}
