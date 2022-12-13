//
//  ProductListResponseModel.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

struct ProductListResponseModel: Codable {
    var header: Header?
    var filters: [String]?
    var products: [Product]?
}

// MARK: - Header
struct Header: Codable {
    var headerTitle, headerDescription: String?
}

// MARK: - Product
struct Product: Codable {
    var name: String?
    var type: TypeEnum?
    var id: Int?
    var color: Color?
    var imageURL: String?
    var colorCode: ColorCode?
    var available: Bool?
    var releaseDate: Int?
    var productDescription, longDescription: String?
    var rating: Double?
    var price: Price?
    
    enum CodingKeys: String, CodingKey {
        case name, type, id, color, imageURL, colorCode, available, releaseDate
        case productDescription = "description"
        case longDescription, rating, price
    }
}

enum Color: String, Codable {
    case blue = "Blue"
    case green = "Green"
    case red = "Red"
    case yellow = "Yellow"
}

enum ColorCode: String, Codable {
    case bbdefb = "BBDEFB"
    case c8E6C9 = "C8E6C9"
    case ffCDD2 = "ffCDD2"
    case ffecb3 = "FFECB3"
}

// MARK: - Price
struct Price: Codable {
    var value: Double?
    var currency: Currency?
}

enum Currency: String, Codable {
    case eur = "EUR"
}

enum TypeEnum: String, Codable {
    case circle = "Circle"
    case hexagon = "Hexagon"
    case square = "Square"
    case triangle = "Triangle"
}
