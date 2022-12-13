//
//  Int+Extension.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import Foundation

extension Int {
    var asDate: Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}
