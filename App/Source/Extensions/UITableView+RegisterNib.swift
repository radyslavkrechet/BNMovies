//
//  UITableView+RegisterNib.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import UIKit

extension UITableView {
    func registerNibForCell<T: UITableViewCell>(_ cell: T.Type) {
        let cellNib = UINib(nibName: T.nameOfClass, bundle: nil)
        register(cellNib, forCellReuseIdentifier: T.nameOfClass)
    }

    func registerNibForHeaderFooterView<T: UITableViewHeaderFooterView>(_ view: T.Type) {
        let viewNib = UINib(nibName: T.nameOfClass, bundle: nil)
        register(viewNib, forHeaderFooterViewReuseIdentifier: T.nameOfClass)
    }
}
