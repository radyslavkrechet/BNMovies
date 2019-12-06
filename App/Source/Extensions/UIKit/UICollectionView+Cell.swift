//
//  UICollectionView+Cell.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerNibForCell<Cell: UICollectionViewCell>(_ cell: Cell.Type) {
        let cellNib = UINib(nibName: Cell.nameOfClass, bundle: nil)
        register(cellNib, forCellWithReuseIdentifier: Cell.nameOfClass)
    }

    func dequeueReusableCellForIndexPath<Cell: UICollectionViewCell>(_ indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: Cell.nameOfClass, for: indexPath) as? Cell ?? Cell()
    }
}
