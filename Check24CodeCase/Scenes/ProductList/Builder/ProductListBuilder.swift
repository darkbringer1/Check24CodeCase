//
//  ProductListBuilder.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import UIKit

final class ProductListBuilder {
    class func build() -> UIViewController {
        let dataFormatter = ProductListDataFormatter()
        let viewModel = ProductListViewModel(dataFormatter: dataFormatter)
        let vc = ProductListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: vc)

        
        return navigationController
    }
}
