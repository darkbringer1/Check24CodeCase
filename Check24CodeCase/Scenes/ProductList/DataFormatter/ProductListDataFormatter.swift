//
//  ProductListDataFormatter.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import Foundation
import SafariServices

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
        self.productList.removeAll()
        self.productList.append(contentsOf: products)
    }
    
    func getItem(at index: Int) -> Product {
        return productList[index]
    }
    
    func getItemId(at index: Int) -> Int {
        return productList[index].id ?? 0
    }
    
    func filterAvailableProducts() {
        productList = productList.filter( {$0.available ==  true })
    }
    
    func filterFavouriteProducts() {
//        productList = productList.filter({ $0})
    }
    
    func getHeaderValues() -> (String, String) {
        return (componentData?.header?.headerTitle ?? "", componentData?.header?.headerDescription ?? "")
    }
    func getFooterValue() -> URL? {
        return URL(string: "http://m.check24.de/rechtliche-hinweise?deviceoutput=app")
    }
    func navigateToWebview(with url: URL) -> UIViewController {
        SFSafariViewController(url: url)
    }
}
