//
//  EndpointManager.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import Foundation

typealias BaseUrl = EndpointManager.BaseURL
typealias Path = EndpointManager.Paths

enum EndpointManager {
    enum BaseURL: GenericValueProtocol {
        typealias Value = String
        
        case main
        var value: String {
            switch self {
                case .main:
                    return "http://app.check24.de/"
            }
        }
    }
    
    enum Paths: GenericValueProtocol {
        typealias Value = String
        
        case products
        
        var value: String {
            switch self {
                case .products:
                    return "products-test.json"
            }
        }
    }
}

