//
//  UITableView+Dequeue.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCellForIndexPath<Cell: UITableViewCell>(_ indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withIdentifier: Cell.nameOfClass, for: indexPath) as? Cell ?? Cell()
    }

    func dequeueReusableHeaderFooterView<View: UITableViewHeaderFooterView>() -> View {
        return dequeueReusableHeaderFooterView(withIdentifier: View.nameOfClass) as? View ?? View()
    }
}
