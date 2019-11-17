//
//  UICollectionView+Dequeue.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCellForIndexPath<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.nameOfClass, for: indexPath) as? T ?? T()
    }

    func dequeueReusableSupplementaryViewForIndexPath<T: UICollectionReusableView>(_ indexPath: IndexPath,
                                                                                   of kind: String) -> T {

        return dequeueReusableSupplementaryView(ofKind: kind,
                                                withReuseIdentifier: T.nameOfClass,
                                                for: indexPath) as? T ?? T()
    }
}
