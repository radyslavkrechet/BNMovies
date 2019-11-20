//
//  UICollectionView+Dequeue.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCellForIndexPath<Cell: UICollectionViewCell>(_ indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: Cell.nameOfClass, for: indexPath) as? Cell ?? Cell()
    }

    func dequeueReusableSupplementaryViewForIndexPath<View: UICollectionReusableView>(_ indexPath: IndexPath,
                                                                                      of kind: String) -> View {

        return dequeueReusableSupplementaryView(ofKind: kind,
                                                withReuseIdentifier: View.nameOfClass,
                                                for: indexPath) as? View ?? View()
    }
}
