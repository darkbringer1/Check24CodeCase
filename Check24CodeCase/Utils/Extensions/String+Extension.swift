//
//  String+Extension.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import Foundation

extension String {
    
    enum DateFormat: String {
        case short
        case medium
        case large
        case long
        
        var value: String {
            switch self {
                case .short:
                    return "MMM yyyy"
                case .medium:
                    return "dd.MM.yyyy"
                case .large:
                    return "dd.MM.yyyy - HH:mm"
                case .long:
                    return "dd MMMM yyyy"
            }
        }
    }
    
    enum DateResponseFormat: String {
        case short
        case long
        
        var value: String {
            switch self {
                case .short:
                    return "yyyy-MM-dd'T'HH:mm:ss'Z'"
                case .long:
                    return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            }
        }
    }
    
    func dateToString(responseFormat: DateResponseFormat = .long, format: DateFormat) -> Self {
        var date = self
        let formatter1 = DateFormatter()
        formatter1.dateFormat = responseFormat.value
        
        if let date2 = formatter1.date(from: date)?.byAdding(.hour, value: 3) {
            let formatter2 = DateFormatter()
            formatter2.dateFormat = format.value
            let dateString = formatter2.string(from: date2)
            date = dateString
        }
        
        return date
    }
}

extension Int {
    var asDate: Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}
