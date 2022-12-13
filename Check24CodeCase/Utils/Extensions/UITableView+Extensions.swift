//
//  UITableView+Extensions.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import UIKit

public protocol IdentifierReusable {
    static var reuseIdentifier: String { get }
}

public extension IdentifierReusable {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

extension UITableViewCell: IdentifierReusable {}

public extension UITableViewCell {
    static func nib(in bundle: Bundle) -> UINib {
        UINib(nibName: Self.reuseIdentifier, bundle: bundle)
    }
}
