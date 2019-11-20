//
//  UICollectionView+RegisterNib.swift
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

    func registerNibForSupplementaryView<View: UICollectionReusableView>(_ cell: View.Type, of kind: String) {
        let viewNib = UINib(nibName: View.nameOfClass, bundle: nil)
        register(viewNib, forSupplementaryViewOfKind: kind, withReuseIdentifier: View.nameOfClass)
    }
}
