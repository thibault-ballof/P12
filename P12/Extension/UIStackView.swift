//
//  UIStackView.swift
//  P12
//
//  Created by Thibault Ballof on 22/08/2022.
//

import UIKit
extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { addArrangedSubview($0) }
    }
}
