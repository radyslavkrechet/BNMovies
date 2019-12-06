//
//  UITableView+Cell.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

extension UITableView {
    func registerNibForCell<Cell: UITableViewCell>(_ cell: Cell.Type) {
        let cellNib = UINib(nibName: Cell.nameOfClass, bundle: nil)
        register(cellNib, forCellReuseIdentifier: Cell.nameOfClass)
    }

    func dequeueReusableCellForIndexPath<Cell: UITableViewCell>(_ indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withIdentifier: Cell.nameOfClass, for: indexPath) as? Cell ?? Cell()
    }
}
