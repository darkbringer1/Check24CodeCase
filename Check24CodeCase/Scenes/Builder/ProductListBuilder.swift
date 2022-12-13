//
//  ProductListBuilder.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import UIKit

final class ProductListBuilder {
    class func build() -> UIViewController {
        let viewModel = ProductListViewModel()
        let vc = ProductListViewController(viewModel: viewModel)
        
        return vc
    }
}
