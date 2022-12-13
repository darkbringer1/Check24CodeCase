//
//  GenericValueProtocol.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import Foundation

public protocol GenericValueProtocol {
    associatedtype Value
    var value: Value { get }
}
