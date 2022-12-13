//
//  ProductListViewModel.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import Foundation
import DefaultNetworkOperationPackage

typealias ProductListResponseBlock = (Result<ProductListResponseModel, ErrorResponse>) -> Void

protocol ProductListViewModelProtocol: AnyObject {
    func getProductList()
}

class ProductListViewModel: ProductListViewModelProtocol {
    
    func getProductList() {
        do {
            guard let urlRequest = try? ProductListServiceProvider(request: EmptyRequestModel()).returnUrlRequest(headerType: .contentTypeUTF8) else { return }
            debugPrint(urlRequest)
            fireApiCall(with: urlRequest, dataListener: dataListener)
        }
    }
    
    private func fireApiCall(with urlRequest: URLRequest, dataListener: @escaping ProductListResponseBlock) {
        APIManager.shared.executeRequest(urlRequest: urlRequest, completion: dataListener)
    }
    
    private lazy var dataListener: (Result<ProductListResponseModel, ErrorResponse>) -> Void = { [weak self] result in
        switch result {
            case .success(let data):
                debugPrint(data)
            case .failure(let error):
                debugPrint(error)
        }
    }
}
