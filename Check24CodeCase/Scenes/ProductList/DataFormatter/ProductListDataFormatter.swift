//
//  ProductListDataFormatter.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import Foundation

class ProductListDataFormatter {
    private var componentData: ProductListResponseModel?
    private var productList: [Product] = [Product]()
    
    func getNumberOfItems() -> Int {
        let count = productList.count
        return count
    }
    
    func setData(with response: ProductListResponseModel) {
        guard let products = response.products else { return }
        self.componentData = response
        self.productList.append(contentsOf: products)
    }
    
    func getItem(at index: Int) -> Product {
        return productList[index]
    }
    
    func getItemId(at index: Int) -> Int {
        return productList[index].id ?? 0
    }
}
