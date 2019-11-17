//
//  UICollectionView+RegisterNib.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerNibForCell<T: UICollectionViewCell>(_ cell: T.Type) {
        let cellNib = UINib(nibName: T.nameOfClass, bundle: nil)
        register(cellNib, forCellWithReuseIdentifier: T.nameOfClass)
    }

    func registerNibForSupplementaryView<T: UICollectionReusableView>(_ cell: T.Type, of kind: String) {
        let cellNib = UINib(nibName: T.nameOfClass, bundle: nil)
        register(cellNib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.nameOfClass)
    }
}
