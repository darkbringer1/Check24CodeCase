//
//  ProductListServiceProvider.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import Foundation
import DefaultNetworkOperationPackage

class ProductListServiceProvider: ApiServiceProvider<EmptyRequestModel> {
    init(request: EmptyRequestModel) {
        super.init(method: .get,
                   baseUrl: BaseUrl.main.value,
                   path: Path.products.value,
                   data: request)
    }
}
