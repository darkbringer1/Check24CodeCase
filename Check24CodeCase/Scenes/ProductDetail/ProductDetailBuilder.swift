//
//  ProductDetailBuilder.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import Foundation
import UIKit

final class ProductDetailBuilder {
    class func build(with productData: Product) -> UIViewController {
        let viewModel = ProductDetailViewModel(productData: productData)
        let vc = ProductDetailViewController(viewModel: viewModel)
        return vc
    }
}
