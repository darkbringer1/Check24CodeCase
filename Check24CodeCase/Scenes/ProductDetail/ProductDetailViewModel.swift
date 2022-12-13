//
//  ProductDetailViewModel.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import Foundation

class ProductDetailViewModel {
    private let productData: Product
    
    init(productData: Product) {
        self.productData = productData
    }
    
    func getProductData() -> Product {
        productData
    }
}
