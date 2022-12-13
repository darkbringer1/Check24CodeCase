//
//  Date+Extension.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import Foundation

extension Date {
    func byAdding(_ component: Calendar.Component, value: Int, calendar: Calendar = .current) -> Date? {
        calendar.date(byAdding: component, value: value, to: self)
    }
    
    var asString: String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.YYYY"
        return formatter.string(from: self)
    }
}
