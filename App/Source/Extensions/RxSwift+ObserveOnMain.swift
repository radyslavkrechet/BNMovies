//
//  RxSwift+ObserveOnMain.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/10/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import RxSwift

extension ObservableType {
    func observeOnMain() -> Observable<Self.E> {
        return self.observeOn(MainScheduler.instance)
    }
}
