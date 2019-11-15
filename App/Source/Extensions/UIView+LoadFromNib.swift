//
//  UIView+LoadFormNib.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import UIKit

extension UIView {
    func loadFromNib(with nibName: String? = nil) {
        if let view = Bundle.main.loadNibNamed(nibName ?? nameOfClass, owner: self)?.first as? UIView {
            addSubview(view)
            addConstraints(to: view)
        }
    }

    func addConstraints(to view: UIView) {
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
